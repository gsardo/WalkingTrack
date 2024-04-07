//
//  ContentView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WalkHistoryView()
                .tabItem {
                    Label("Walks", systemImage: "signpost.right.and.left.circle")
                }
            
            WishlistView()
                .tabItem {
                    Label("Wishlist", systemImage: "star.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
