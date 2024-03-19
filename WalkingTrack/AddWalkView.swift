//
//  AddWalkView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import PhotosUI
import SwiftUI

struct AddWalkView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State private var nationalPark = ""
    @State private var trailName = ""
    @State private var state = "NSW"
    @State private var review = ""
    
    let states = ["ACT", "NSW", "NT", "QLD", "SA", "TAS", "VIC", "WA"]
    
    var isFormValid: Bool {
        if nationalPark.trimmingCharacters(in: .whitespaces).isEmpty || trailName.trimmingCharacters(in: .whitespaces).isEmpty || state.trimmingCharacters(in: .whitespaces).isEmpty {
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
                    
                    Picker("Location", selection: $state) {
                        ForEach(states, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                }
                
                
                Section {
                    if let selectedPhotoData,
                       let uiImage = UIImage(data: selectedPhotoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
                    }
                    
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Label("Select a picture", systemImage: "photo")
                    }
                }
                
                Section {
                    Button("Save") {
                        let newWalk = Walk(nationalPark: nationalPark, trailName: trailName, state: state, review: review, image: selectedPhotoData)
                        modelContext.insert(newWalk)
                        dismiss()
                    }
                    .disabled(isFormValid == false)
                }
            }
            .navigationTitle("Add walk")
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
    }
}

#Preview {
    AddWalkView()
}
