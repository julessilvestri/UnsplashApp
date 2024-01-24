//
//  Topic.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation

struct TopicElement: Codable, Identifiable {
    let id: String
    let slug: String
    let title: String
    let coverPhoto : CoverTopic
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case coverPhoto = "cover_photo"
    }
}

struct CoverTopic: Codable{
    let urls: UnsplashPhotoUrls
}


struct PreviewPhoto: Codable {
    let id, title: String
    let urls: UnsplashPhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case urls
    }
}
