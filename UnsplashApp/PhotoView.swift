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
    
    enum PhotoSize: String, CaseIterable {
        case regular = "regular"
        case full = "full"
        case small = "small"
    }
    
    @State var selectedPhotoSize: PhotoSize = .regular
    
    var body: some View {
        VStack {
            Text("Une photo de \(photo.author.firstName ?? "inconnu") \(photo.author.lastName ?? "")")
            Text("\(selectedPhotoSize.rawValue)")
            
            Picker("PhotoSize", selection: $selectedPhotoSize) {
                ForEach(PhotoSize.allCases, id: \.self) { size in
                    Text(size.rawValue)
                }
            }
            .pickerStyle(PalettePickerStyle())
            
            switch selectedPhotoSize {
                case .small:
                    AsyncImage(url: URL(string: photo.url.small))
                case .full:
                    AsyncImage(url: URL(string: photo.url.full))
                case .regular:
                    AsyncImage(url: URL(string: photo.url.regular))
            }
        }
            
        
    }
}



