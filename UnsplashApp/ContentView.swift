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
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case name
    }
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
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
                    }
                }, label: {
                    Text("Load Data")
                })
                if let homeFeed = feedState.homeFeed {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8){
                            ForEach(homeFeed) { image in
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
                    .navigationBarTitle("Feed")
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
