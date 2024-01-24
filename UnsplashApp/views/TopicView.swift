//
//  TopicView.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation
import SwiftUI

struct TopicView: View {
    let columns = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    @StateObject var feedState = FeedState()
    let topic: TopicElement
    
    var body: some View {
        NavigationStack{
            VStack {
                Button(action: {
                    Task {
                        await feedState.fetchTopicPhotosFeed(idTopic: topic.id)
                    }
                }, label: {
                    Text("Load photos for topic")
                })
            }
            
            if let topicFeed = feedState.topicPhotos {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8){
                        ForEach(topicFeed, id: \.id) { image in
                            PhotoCard(image: image)
                        }
                    }
                }
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .navigationBarTitle(topic.slug)
            }
            else{
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8){
                        ForEach(0..<12, id: \.self) { image in
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .redacted(reason: .placeholder)
            }
        }
    }
}
