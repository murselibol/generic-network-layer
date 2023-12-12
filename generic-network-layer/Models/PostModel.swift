//
//  PostModel.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 25.11.2023.
//

import Foundation

struct Post: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
