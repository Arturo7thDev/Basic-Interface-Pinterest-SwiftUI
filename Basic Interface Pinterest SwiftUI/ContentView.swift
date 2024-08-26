//
//  ContentView.swift
//  Basic Interface Pinterest SwiftUI
//
//  Created by Arturo Gonzalez on 26/08/24.
//

import SwiftUI

struct PinterestHomeView: View {
    @State private var images = ["Pokemon-Setup", "Tloz-Tattoo", "Setup-Zelda", "Apple-Watch-Wallpaper", "Super-Mario", "Tokio"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryTabView(images: $images)
                DynamicGridView(images: $images)
                CustomTabBarView()
            }
            .navigationBarHidden(true)
        }
    }
}

struct CategoryTabView: View {
    @State private var selectedCategory = "Todas"
    let categories = ["Todas", "Setup Ideas"]
    @Binding var images: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Text(category)
                            .font(.headline)
                            .fontWeight(selectedCategory == category ? .bold : .regular)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.clear)
                        
                        // Subrayado de la categoría seleccionada
                        if selectedCategory == category {
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 2)
                                .cornerRadius(1)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        selectedCategory = category
                        // Cambia las imágenes mostradas según la categoría seleccionada
                        if category == "Setup Ideas" {
                            images = ["Pokemon-Setup", "Setup-Zelda",]
                        } else {
                            images = ["Pokemon-Setup", "Tloz-Tattoo", "Setup-Zelda", "Apple-Watch-Wallpaper", "Super-Mario", "Tokio"]
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white.shadow(radius: 2))
    }
}

struct DynamicGridView: View {
    @Binding var images: [String]
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth / 2) - 24
        
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.fixed(itemWidth), spacing: 16),
                GridItem(.fixed(itemWidth), spacing: 16)
            ], spacing: 16) {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: itemWidth, height: CGFloat.random(in: 150...300))
                        .clipped()
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
        }
    }
}

struct CustomTabBarView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "magnifyingglass")
            Spacer()
            Image(systemName: "plus.app.fill")
            Spacer()
            Image(systemName: "bell")
            Spacer()
            Image(systemName: "person.crop.circle")
            Spacer()
        }
        .padding()
        .background(Color.white.shadow(radius: 2))
    }
}

struct PinterestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PinterestHomeView()
    }
}
