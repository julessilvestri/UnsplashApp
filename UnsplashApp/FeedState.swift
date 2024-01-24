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
            if let url = UnsplashAPI.feedUrl() {
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
}
