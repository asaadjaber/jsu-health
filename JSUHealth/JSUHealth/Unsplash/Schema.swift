//
//  Schema.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 18/09/2024.
//

import Foundation

struct Schema {
    let location = "https://api.unsplash.com/"
    
    enum Headers: String {
        var value: String {
            switch self {
            case .acceptVersion:
                return "v1"
            }
        }
        
        case acceptVersion = "Accept-Version"
    }
    
    enum QueryParameters: String {
        case clientID = "gfAJF7q3g033llRmvt3OWMZAKHI9W_O2Ue4UN9zVOAs"
        case page = "1"
        case perPage = "10"
    }
} 

enum ErrorMessage {
    
    static let ok = "Everything worked as expected."
    
    static let badRequest = "The request was unacceptable, often due to missing a required parameter."
    
    static let unauthorized = "Invalid Access Token."
    
    static let forbidden = "Missing permissions to perform request."
    
    static let notFound = "The requested resource doesn’t exist."
    
    static let error = "Something went wrong on our end."
}
