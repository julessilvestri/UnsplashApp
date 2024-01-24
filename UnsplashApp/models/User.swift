//
//  User.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation

struct User: Codable {
    let id, username: String
    let firstName, lastName : String?
    let profileUser: ProfileUser
    let links: Links
    
    enum CodingKeys: String, CodingKey{
        case id, username, links
        case firstName = "first_name"
        case lastName = "last_name"
        case profileUser = "profile_image"
    }
}

struct Links: Codable {
    let html: String
    
    enum CodingKeys: String, CodingKey{
        case html
    }
}

struct ProfileUser: Codable{
    let small, medium, large: String
}
