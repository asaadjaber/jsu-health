//
//  PhotoProvider.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 18/09/2024.
//

import Foundation
import SwiftyJSON

protocol RequestProvider {
    func request(from: URLRequest) async -> (Data?, URLResponse?)
}

protocol ImageProvider {
    func downloadImage(url: String) async -> (Data?, URLResponse?)
}

struct Body: Decodable {
    var results: [PhotoSearchResult]
}

struct PhotoSearchResult: Decodable {
    var user: User
}

struct User: Decodable {
    var profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    var small: String
    var medium: String
    var large: String
}

struct PhotoProvider: RequestProvider, ImageProvider {
    
    let schema = Schema()
    
    let urlSession: URLSession = URLSession.shared
    
    func request(from urlRequest: URLRequest) async -> (Data?, URLResponse?) {
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            let statusCode = (response as! HTTPURLResponse).statusCode
            guard statusCode == 200 else { return (nil, response)}
            print(String(data: data, encoding: .utf8)!)
            return (data, response)
        } catch {
            print("error fetching data.")
        }
        return (nil, nil)
    }
    
    func makeURLRequest(query: String) -> URLRequest {
        var url: URL = URL(string: schema.location)!
        url.append(path: "search/photos")
        var request = URLRequest(url: url)
        request.setValue(Schema.Headers.acceptVersion.value, forHTTPHeaderField: Schema.Headers.acceptVersion.rawValue)
        request.url?.append(queryItems: [
            URLQueryItem(name: "client_id", value: Schema.QueryParameters.clientID.rawValue),
            URLQueryItem(name: "page", value: Schema.QueryParameters.page.rawValue),
            URLQueryItem(name: "per_page", value: Schema.QueryParameters.page.rawValue),
            URLQueryItem(name: "query", value: query)
        ])
        return request
    }
    
    func downloadImage(url: String) async -> (Data?, URLResponse?) {
        do {
            let (data, response) = try await urlSession.data(from: URL(string: url)!)
            let statusCode = (response as! HTTPURLResponse).statusCode
            guard statusCode == 200 else { return (nil, response)}
            return (data, response)
        } catch {
            print("error downloading image.")
        }
        return (nil, nil)
    }
}
