//
//  Wishlist.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 9/4/2024.
//

import Foundation
import SwiftData

@Model
class Wishlist {
    var nationalPark: String
    var trailName: String
    var difficulty: String
    
    init(nationalPark: String, trailName: String, difficulty: String) {
        self.nationalPark = nationalPark
        self.trailName = trailName
        self.difficulty = difficulty
    }
}
