//
//  WishlistView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 7/4/2024.
//

import SwiftUI

struct WishlistView: View {
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            Text("Walks on my wishlist")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add new wishlist item", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddWishlistItemView()
                }
        }
    }
}

#Preview {
    WishlistView()
}
