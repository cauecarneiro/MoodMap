//
//  NotificationManager.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import Foundation
import SwiftUI

class NotificationManager {
    
    private(set) var isAllowedtoSendNotifications: Bool = false
    private(set) var isSubscribedToNotifications: Bool = false
    
    func requestAuthorizationToNotifications() {
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: options) { [weak self] result, error in
            guard let self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if result {
                Task { @MainActor in UIApplication.shared.registerForRemoteNotifications() }
                self.isAllowedtoSendNotifications = true
            }
        }
    }
}
