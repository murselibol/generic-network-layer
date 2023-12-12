//
//  PostReqModel.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 25.11.2023.
//

import Foundation

struct PostReq: Codable {
   var title: String?
   var body: String?
   var userId: Int?
}
