//
//  PostProvider.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 29.11.2023.
//

import Foundation

enum PostProvider {
    case posts(queryItems: [String: String])
    case post(body: PostReq)
}

extension PostProvider: Endpoint {
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .post:
            return "/posts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .posts:
            return .get
        case .post:
            return .post
        }
    }

    var queryItems: [String : Any]? {
        switch self {
        case .posts(let queryItems):
            return queryItems
        default:
            return nil
        }
    }

    var body: Encodable? {
        switch self {
        case .posts:
            return nil
        case .post(let body):
            return body
        }
    }
}
