//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/23/24.
//

import Foundation

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?

    func fetchHomeFeed() async {
        do {
            if let url = UnsplashAPI.feedUrl(endpointApi: "/photos") {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                DispatchQueue.main.async {
                    self.homeFeed = deserializedData
                }
            }
        } catch {
            print("Error fetching photo feed: (error)")
        }
    }
    
    @Published var topic: [TopicElement]?

    func fetchTopicFeed() async {
        do {
            if let url = UnsplashAPI.feedUrl(endpointApi: "/topics") {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let deserializedData = try JSONDecoder().decode([TopicElement].self, from: data)
                DispatchQueue.main.async {
                    self.topic = deserializedData
                }
            }
        } catch {
            print("Error fetching topic: (error)")
        }
    }
    
    @Published var topicPhotos: [UnsplashPhoto]?

    func fetchTopicPhotosFeed(idTopic id: String) async {
        do {
            if let url = UnsplashAPI.feedUrl(endpointApi: "/topics/\(id)/photos") {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                DispatchQueue.main.async {
                    self.topicPhotos = deserializedData
                }
            }
        } catch {
            print("Error fetching topic: (error)")
        }
    }
}
