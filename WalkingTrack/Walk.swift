//
//  Walk.swift
//  WalkingTrack
//
//  Created by Giuseppe Sardo on 29/1/2024.
//

import Foundation
import SwiftData

@Model
class Walk {
    var nationalPark: String
    var trailName: String
    var state: String
    var review: String
    var image: Data?
    
    init(nationalPark: String, trailName: String, state: String, review: String, image: Data?) {
        self.nationalPark = nationalPark
        self.trailName = trailName
        self.state = state
        self.review = review
        self.image = image
    }
}
