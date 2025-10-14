//
//  Moods.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import Foundation

enum Moods: String {
    case happy, sad, angry, bored, relaxed
    
    var emoji: String {
        switch self {
        case .happy:
            "😁"
        case .sad:
            "😔"
        case .angry:
            "😡"
        case .bored:
            "🥱"
        case .relaxed:
            "😌"
        }
    }
}
