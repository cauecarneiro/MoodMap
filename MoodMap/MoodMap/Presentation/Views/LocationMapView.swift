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
    let userLocationRequest = UserLocationManager()
    
    let academyPoint = MapAnnotationsModel(localName: "Apple Developer Academy UCB", localCoordinates: .academy, localSFSymbol: "apple.logo")
    let ucbPoint = MapAnnotationsModel(localName: "Universidade Católica de Brasília", localCoordinates: .ucb, localSFSymbol: "book.fill")
        
    var body: some View {
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
//        .mapStyle(.standard (elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            userLocationRequest.requestUserLocation()
        }
    }
}

#Preview {
    LocationMapView()
}
