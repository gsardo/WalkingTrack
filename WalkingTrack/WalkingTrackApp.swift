//
//  WalkingTrackApp.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import SwiftData
import SwiftUI

@main
struct WalkingTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Walk.self, Wishlist.self])
    }
}
