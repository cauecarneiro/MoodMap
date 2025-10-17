//
//  CloudKitErrors.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import Foundation

enum CloudKitErrors: String, LocalizedError {
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountNotAvailable
    case iCloudAccontUnknown
}

