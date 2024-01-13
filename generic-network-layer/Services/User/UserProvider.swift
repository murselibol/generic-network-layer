//
//  UserProvider.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 29.11.2023.
//

import Foundation

enum UserProvier {
    case users(id: Int)
}

extension UserProvier: Endpoint {
    var path: String {
        switch self {
        case .users(let id):
            "/users/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: Encodable? {
        return nil
    }
}
