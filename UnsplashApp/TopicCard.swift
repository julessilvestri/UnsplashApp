//
//  TopicCard.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/24/24.
//

import Foundation
import SwiftUI

struct TopicCard: View {
    let topic: TopicElement
    
    var body: some View {
        VStack {            
            AsyncImage(url: URL(string: topic.coverPhoto.urls.small))
                .frame(width: 100, height: 60)
                .cornerRadius(12)
            Text(topic.title)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
    }
}
