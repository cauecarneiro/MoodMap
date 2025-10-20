//
//  MapAnnotationsModel.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 17/10/25.
//

import Foundation
import CoreLocation

class MapAnnotationsModel {
    let localName: String
    let localCoordinates: CLLocationCoordinate2D
    let localSFSymbol: String
    
    init(localName: String, localCoordinates: CLLocationCoordinate2D, localSFSymbol: String) {
        self.localName = localName
        self.localCoordinates = localCoordinates
        self.localSFSymbol = localSFSymbol
    }
}
