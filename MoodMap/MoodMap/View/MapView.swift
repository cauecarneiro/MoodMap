//
//  ContentView.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    let academyPoint = MapAnnotationsModel(nomeLocal: "Apple Developer Academy UCB", coordenadasLocal: .academy, sfSymbolLocal: "apple.logo")
    let ucbPoint = MapAnnotationsModel(nomeLocal: "Universidade Católica de Brasília", coordenadasLocal: .ucb, sfSymbolLocal: "book.fill")
    
    var body: some View {
        Map {
            Annotation(academyPoint.nomeLocal, coordinate: academyPoint.coordenadasLocal) {
                HStack(spacing: 6) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.background)
                        Image(systemName: academyPoint.sfSymbolLocal)
                            .padding(8)
                    }
                }
            }
            
            Annotation(ucbPoint.nomeLocal, coordinate: ucbPoint.coordenadasLocal) {
                HStack(spacing: 6) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.background)
                        Image(systemName: ucbPoint.sfSymbolLocal)
                            .padding(8)
                    }
                }
            }
        }
//        .mapStyle(.standard (elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}

#Preview {
    MapView()
}
