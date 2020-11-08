//
//  Feed.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation

struct Feed: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let post: String
    let timestamp: Double
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case post = "post_body"
        case timestamp = "unix_timestamp"
        case image
    }
}
