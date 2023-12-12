//
//  UserService.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 25.11.2023.
//

import Foundation

protocol UserServiceProtocol {
    func getUser(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void)
}

final class UserService: UserServiceProtocol {
    
    static let shared = UserService()
    private init() {}
    
    func getUser(id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let request = UserProvier.users(id: id).request()
        NetworkManager.shared.request(request, completion: completion)
    }
    
}
