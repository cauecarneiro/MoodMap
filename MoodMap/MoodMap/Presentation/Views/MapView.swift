//
//  ContentView.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//

import SwiftUI

struct MapView: View {
    
    @StateObject private var notificationManager = NotificationManager()
    @State private var notificationStatus: NotificationStatus = .notAllowed
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("MoodMap")
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        handleNotifications()
                    } label: {
                        Label("Notifications", systemImage: notificationStatus.image)
                    }
                }
            }
        }
    }
    
}


extension MapView {
    func handleNotifications() {
        Task {
            if !notificationManager.allowedNotifications {
                await notificationManager.requestAuthorizationToNotifications()
                notificationStatus = .unsubscribed
            }
            
            if !notificationManager.subscribedToNotification {
                await notificationManager.subscribeToNotification(
                    recordType: GlobalValues.recordType,
                    subscriptionID: GlobalValues.subscriptionID
                )
                notificationStatus = .subscribed
            } else {
                await notificationManager.unsubscribeToNotification(subscriptionID: GlobalValues.subscriptionID)
                notificationStatus = .unsubscribed
            }
        }
    }
}

#Preview {
    MapView()
}
