//
//  Walk.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import SwiftData
import Foundation

@Model
class Walk {
    var nationalPark: String
    var trailName: String
    var state: String
    var review: String
    
    init(nationalPark: String, trailName: String, state: String, review: String) {
        self.nationalPark = nationalPark
        self.trailName = trailName
        self.state = state
        self.review = review
    }
}
