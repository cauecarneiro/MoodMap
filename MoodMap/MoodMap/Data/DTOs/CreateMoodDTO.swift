//
//  CreateMoodDTO.swift
//  MoodMap
//
//  Created by Breno Marques on 16/10/25.
//

import CoreLocation

struct CreateMoodDTO {
    let id: UUID
    let feeling: String
    let description: String
    let location: CLLocation
}
