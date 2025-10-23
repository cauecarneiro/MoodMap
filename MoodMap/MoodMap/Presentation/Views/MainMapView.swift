//
//  MainMapView.swift
//  MoodMap
//
//  Created by AI Assistant on 21/10/25.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var cloudKitManager = CloudKitManager()
    @State private var notificationStatus: NotificationStatus = .notAllowed
    @State private var isPresentingPopover = false
    @State private var textOpinion: String = ""
    
    let userLocationRequest = UserLocationManager()
    let academyPoint = MapAnnotationsModel(localName: "Apple Developer Academy UCB", localCoordinates: .academy, localSFSymbol: "apple.logo")
    let ucbPoint = MapAnnotationsModel(localName: "Universidade Católica de Brasília", localCoordinates: .ucb, localSFSymbol: "book.fill")
    
    var body: some View {
        NavigationView {
            ZStack {
                // Mapa principal
                Map {
                    ForEach(cloudKitManager.moods, id:\.self) { mood in
                        Annotation(mood.title, coordinate: CLLocationCoordinate2D(latitude: mood.location.coordinate.latitude, longitude: mood.location.coordinate.longitude)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.background)
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(.blue)
                                    .padding(8)
                            }
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
                
                // Botões de controle no lado esquerdo
                VStack {
                    Spacer()
                    
                    // Botão Avaliar Local
                    Button(action: {
                        isPresentingPopover = true
                    }) {
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.leading, 330)
                    .padding(.bottom, 480)
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if let location = userLocationRequest.userLocation {
                            print("Latitude: \(location.latitude)")
                            print("Longitude: \(location.longitude)")
                        }
                    } label: {
                        Label("Map", systemImage: "map.fill")
                    }
                }
            }
            .sheet(isPresented: $isPresentingPopover) {
                MoodPopoverView(textReview: $textOpinion, location: userLocationRequest.userLocation)
                    .onDisappear {
                        isPresentingPopover = false
                    }
            }
        }
    }
}

extension MainMapView {
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
    MainMapView()
}
