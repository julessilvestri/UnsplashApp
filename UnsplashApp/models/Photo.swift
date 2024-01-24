//
//  Photo.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let author: User
    let url: UnsplashPhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case author = "user"
        case url = "urls"
    }
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

enum PhotoSize: String, CaseIterable {
    case Small = "small"
    case Regular = "regular"
    case Full = "full"
}
