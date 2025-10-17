//
//  MapAnnotationsModel.swift
//  MoodMap
//
//  Created by Rodrigo Barbosa Pereira on 17/10/25.
//

import Foundation
import CoreLocation

struct MapAnnotationsModel {
    let nomeLocal: String
    let coordenadasLocal: CLLocationCoordinate2D
    let sfSymbolLocal: String

    init(nomeLocal: String, coordenadasLocal: CLLocationCoordinate2D, sfSymbolLocal: String) {
        self.nomeLocal = nomeLocal
        self.coordenadasLocal = coordenadasLocal
        self.sfSymbolLocal = sfSymbolLocal
    }
}
