//
//  MockGetPhotoRequest.swift
//  JSUHealthTests
//
//  Created by Asaad Jaber on 18/09/2024.
//

@testable import JSUHealth

import Foundation

final class MockPhotoProvider: RequestProvider, ImageProvider {
    
    enum Response {
        case value(Data, URLResponse)
        case error(Error)
    }
    
    private let response: Response
    
    init(response: Response) {
        self.response = response
    }
    
    func request(from: URLRequest) async -> (Data?, URLResponse?) {
        switch response {
          case .value(let data, let response):
              return (data, response)
          case .error(let error):
              return (nil, nil)
          }
    }
    
    func makeURLRequest(query: String) -> URLRequest {
        var url: URL = URL(string: "http://123.com")!
        url.append(path: "search/photos")
        var request = URLRequest(url: url)
        request.setValue(Schema.Headers.acceptVersion.value, forHTTPHeaderField: Schema.Headers.acceptVersion.rawValue)
        request.url?.append(queryItems: [
            URLQueryItem(name: "client_id", value: "123"),
            URLQueryItem(name: "page", value: "0"),
            URLQueryItem(name: "per_page", value: "5"),
            URLQueryItem(name: "query", value: query)
        ])
        return request
    }
    
    func downloadImage(url: String) async -> (Data?, URLResponse?) {
        switch response {
        case .value(let data, let response):
            return (data, response)
        case .error(let error):
            return (nil, nil)
        }
    }
}
