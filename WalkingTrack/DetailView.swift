//
//  DetailView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let walk: Walk
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(walk.state)
                    .resizable()
                    .scaledToFit()
                
                Text(walk.nationalPark.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(walk.trailName)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.top)
            
            Text(walk.state)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(walk.review)
                .padding()
                .font(.callout)
            
            
            
            if let selectedPhotoData = walk.image,
               let uiImage = UIImage(data: selectedPhotoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 10, style: .continuous)
                    )
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete walk", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteWalk)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this walk", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteWalk() {
        modelContext.delete(walk)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Walk.self, configurations: config)
        let example = Walk(nationalPark: "Great Forest", trailName: "Great Walk", state: "NSW", review: "Breathtaking", image: nil)
        
        return DetailView(walk: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
