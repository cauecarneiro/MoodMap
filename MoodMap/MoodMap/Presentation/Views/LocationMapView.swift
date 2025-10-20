//
//  LocationMapView.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//  Modified by Rodrigo Barbosa Pereira on 17/10/25.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @StateObject private var notificationManager = NotificationManager()
    @State private var notificationStatus: NotificationStatus = .notAllowed
    
    let userLocationRequest = UserLocationManager()
    
    let academyPoint = MapAnnotationsModel(localName: "Apple Developer Academy UCB", localCoordinates: .academy, localSFSymbol: "apple.logo")
    let ucbPoint = MapAnnotationsModel(localName: "Universidade Católica de Brasília", localCoordinates: .ucb, localSFSymbol: "book.fill")
        
    var body: some View {
        NavigationView {
            Map {
                Annotation(academyPoint.localName, coordinate: academyPoint.localCoordinates) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.background)
                        Image(systemName: academyPoint.localSFSymbol)
                            .foregroundStyle(.blue)
                            .padding(8)
                    }
                }
                
                Annotation(ucbPoint.localName, coordinate: ucbPoint.localCoordinates) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.background)
                        Image(systemName: ucbPoint.localSFSymbol)
                            .foregroundStyle(.gray)
                            .padding(8)
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .onAppear {
                userLocationRequest.requestUserLocation()
            }
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


extension LocationMapView {
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
    LocationMapView()
}
