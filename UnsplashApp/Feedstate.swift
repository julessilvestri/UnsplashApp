//
//  Feedstate.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/23/24.
//

import SwiftUI
import Combine

class FeedState: ObservableObject {
    @Published var feedItems: [FeedItem] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchData()
    }

    func fetchData() {
        if let feedURL = UnsplashAPI.feedUrl() {
            URLSession.shared.dataTaskPublisher(for: feedURL)
                .map(\.data)
                .decode(type: [FeedItem].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching data: \(error)")
                    }
                } receiveValue: { [weak self] items in
                    self?.feedItems = items
                }
                .store(in: &cancellables)
        }
    }
}

struct FeedItem: Decodable {
    // Définissez ici la structure de vos données de l'API
}

