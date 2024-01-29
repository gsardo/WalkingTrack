//
//  ContentView.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Walk.trailName) var walks: [Walk]
    @State private var showingAddScreen = false
    @State private var sortOrder = [
        SortDescriptor(\Walk.trailName),
        SortDescriptor(\Walk.state)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(walks) { walk in
                    NavigationLink(value: walk) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(walk.trailName)
                                    .font(.headline)
                                
                                Text(walk.nationalPark)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteWalks)
            }
            .navigationTitle("WalkingTrack")
            .navigationDestination(for: Walk.self){ walk in
                DetailView(walk: walk)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new walk", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by state")
                                .tag([
                                    SortDescriptor(\Walk.state),
                                    SortDescriptor(\Walk.trailName)
                                ])
                            
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\Walk.trailName),
                                    SortDescriptor(\Walk.state)
                                ])
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddWalkView()
            }
        }
    }
    
    func deleteWalks(at offsets: IndexSet) {
        for offset in offsets {
            let walk = walks[offset]
            modelContext.delete(walk)
        }
    }
}

#Preview {
    ContentView()
}
