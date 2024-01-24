//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/23/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let columns = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    @State var imageList: [UnsplashPhoto] = []
    @StateObject var feedState = FeedState()
    
    var body: some View {
        NavigationStack{
            VStack {
                Button(action: {
                    Task {
                        await feedState.fetchHomeFeed()
                        await feedState.fetchTopicFeed()
                    }
                }, label: {
                    Text("Load Data")
                })
                
                if let topics = feedState.topic {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(topics, id: \.id) { topic in
                                NavigationLink(destination: TopicView(topic: topic)){
                                    TopicCard(topic: topic)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                    }
                }                
            }
            
            if let homeFeed = feedState.homeFeed {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8){
                        ForEach(homeFeed) { image in
                            PhotoCard(image: image)
                        }
                    }
                }
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .navigationBarTitle("Feed")
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



#Preview {
    ContentView()
}
