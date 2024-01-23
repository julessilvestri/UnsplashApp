//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Jules SILVESTRI on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    
    let columns = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
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
    
    // Déclaration d'une variable d'état, une fois remplie, elle va modifier la vue
    @State var imageList: [UnsplashPhoto] = []
    
    // Déclaration d'une fonction asynchrone
    func loadData() async {
        // Créez une URL avec la clé d'API
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(ConfigurationManager.instance.plistDictionnary.clientId)")!
        
        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)
            
            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            // Mettez à jour l'état de la vue
            imageList = deserializedData
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    // Créez cette nouvelle structure visuelle
    var body: some View {
        VStack {
            // le bouton va lancer l'appel réseau
            Button(action: {
                Task {
                    await loadData()
                }
            }, label: {
                Text("Load Data")
            })
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8){
                    ForEach(imageList) { image in
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
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .navigationBarTitle("Feed")
            
        }
    }
}


#Preview {
    ContentView()
}
