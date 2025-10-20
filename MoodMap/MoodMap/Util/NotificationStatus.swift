//
//  NotificationStatus.swift
//  MoodMap
//
//  Created by Breno Marques on 20/10/25.
//

import Foundation

enum NotificationStatus: String {
    case notAllowed, subscribed, unsubscribed
    
    var image: String {
        switch self {
        case .notAllowed:
            "bell.slash.fill"
        case .subscribed:
            "bell.and.waves.left.and.right.fill"
        case .unsubscribed:
            "bell.fill"
        }
    }
}
