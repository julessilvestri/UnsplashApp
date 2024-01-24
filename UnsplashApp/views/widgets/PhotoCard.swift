//
//  PhotoCard.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation
import SwiftUI

struct PhotoCard: View{
    let image: UnsplashPhoto
    
    var body: some View {
        NavigationLink(destination: PhotoView(photo: image)){
            AsyncImage(url: URL(string: image.url.small)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 150)
            .cornerRadius(12)
        }
    }
}

