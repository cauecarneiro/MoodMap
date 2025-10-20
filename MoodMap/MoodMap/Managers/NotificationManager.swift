//
//  NotificationManager.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import SwiftUI
import Combine
import CloudKit

@MainActor
class NotificationManager: ObservableObject {
    
    @Published var allowedNotifications: Bool = false
    @Published var subscribedToNotification: Bool = false
    
    
    func requestAuthorizationToNotifications() async {
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        
        do {
            guard try await UNUserNotificationCenter.current().requestAuthorization(options: options) else {
                print("Not allowed!")
                return
            }
            
            Task { @MainActor in
                UIApplication.shared.registerForRemoteNotifications()
                self.allowedNotifications = true
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func subscribeToNotification(recordType: String, subscriptionID: String) async {
        let subscription = CKQuerySubscription(
            recordType: recordType,
            predicate: NSPredicate(value: true),
            subscriptionID: subscriptionID,
            options: .firesOnRecordCreation
        )
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "New mood added! 🫣"
        notification.alertBody = "Come check what people are talking about this place."
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        do {
            try await CloudKitManager.container.publicCloudDatabase.save(subscription)
            print("Subscribed successfully!")
            
            Task { @MainActor in self.subscribedToNotification = true }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func unsubscribeToNotification(subscriptionID: String) async {
        do {
            try await CloudKitManager.container.publicCloudDatabase.deleteSubscription(withID: subscriptionID)
            print("Unsubscribed successfully!")
            
            Task { @MainActor in self.subscribedToNotification = false }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
