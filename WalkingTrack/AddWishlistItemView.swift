//
//  AddWishlistItemView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 7/4/2024.
//

import SwiftUI

struct AddWishlistItemView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var nationalPark = ""
    @State private var trailName = ""
    @State private var difficulty = ""
    
    let difficultyRating = ["Easy", "Medium", "Hard"]
    
    var isFormValid: Bool {
        if nationalPark.trimmingCharacters(in: .whitespaces).isEmpty || trailName.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("National park", text: $nationalPark)
                    TextField("Trail name", text: $trailName)
                    
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(difficultyRating, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Button("Add to wishlist") {
                        let newWishlist = Wishlist(nationalPark: nationalPark, trailName: trailName, difficulty: difficulty)
                        modelContext.insert(newWishlist)
                        dismiss()
                    }
                }
                .disabled(isFormValid == false)
            }
        }
        .navigationTitle("Add wishlist")
    }
}

#Preview {
    AddWishlistItemView()
}
