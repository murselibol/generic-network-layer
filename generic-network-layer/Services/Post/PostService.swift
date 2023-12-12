//
//  PostService.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 25.11.2023.
//

import Foundation

protocol PostServiceProtocol {
    func getPosts(queryItems: [String: String], completion: @escaping (Result<[Post], NetworkError>) -> Void)
    func create(body: PostReq, completion: @escaping (Result<PostReq, NetworkError>) -> Void)
}

final class PostService: PostServiceProtocol {
    
    static let shared = PostService()
    private init() {}
    
    func getPosts(queryItems: [String: String] = [:], completion: @escaping (Result<[Post], NetworkError>) -> Void) {
         let request = PostProvider.posts(queryItems: queryItems).request()
         NetworkManager.shared.request(request, completion: completion)
        
    }
    
    func create(body: PostReq, completion: @escaping (Result<PostReq, NetworkError>) -> Void) {
        let request = PostProvider.post(body: body).request()
        NetworkManager.shared.request(request, completion: completion)
    }
}
