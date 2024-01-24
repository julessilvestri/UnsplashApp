//
//  TopicView.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation
import SwiftUI

struct PhotoView: View {
    @StateObject var feedState = FeedState()
    let photo: UnsplashPhoto
    
    @State var selectedPhotoSize: PhotoSize = .Regular
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                    if let url = URL(string: photo.author.links.html) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    AsyncImage(url: URL(string: photo.author.profileUser.large)){ image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height:50)
                    .cornerRadius(25)
                }
                
                Text("\(photo.author.firstName ?? "inconnu") \(photo.author.lastName ?? "")")
            }
            
            Picker("PhotoSize", selection: $selectedPhotoSize) {
                ForEach(PhotoSize.allCases, id: \.self) { size in
                    Text(size.rawValue)
                }
            }
            .pickerStyle(PalettePickerStyle())
            
            switch selectedPhotoSize {
            case .Small:
                AsyncImage(url: URL(string: photo.url.small)){ image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            case .Full:
                AsyncImage(url: URL(string: photo.url.full)){ image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            case .Regular:
                AsyncImage(url: URL(string: photo.url.regular)){ image in
                    image.resizable().aspectRatio(contentMode: .fit)
                }placeholder: {
                    ProgressView()
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
