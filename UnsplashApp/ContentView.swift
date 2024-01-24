//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/23/24.
//

import SwiftUI
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

struct User: Codable {
    let id, username: String
    let firstName, lastName : String?
    
    enum CodingKeys: String, CodingKey{
        case id, username
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

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
    let id, slug: String
    let urls: UnsplashPhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case urls
    }
}

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
                            NavigationLink(destination: PhotoView(photo: image)){
                                AsyncImage(url: URL(string: image.url.regular)){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 150)
                                .cornerRadius(12)
                            }
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
