//
//  WishlistView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 7/4/2024.
//

import SwiftData
import SwiftUI

struct WishlistView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Wishlist.difficulty) var wishlists: [Wishlist]
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishlists) { wishlist in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(wishlist.trailName)
                                .font(.headline)
                            HStack {
                                Text(wishlist.nationalPark)
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                Text("Grade: \(wishlist.difficulty)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteWishlistItem)
            }
            .navigationTitle("Walk Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
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
    
    func deleteWishlistItem(at offsets: IndexSet) {
        for offset in offsets {
            let wishlistItem = wishlists[offset]
            modelContext.delete(wishlistItem)
        }
    }
}

#Preview {
    WishlistView()
}
