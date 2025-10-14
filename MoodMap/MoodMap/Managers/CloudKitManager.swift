//
//  CloudKitManager.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import CloudKit

class CloudKitManager {
    
    private(set) var isSignedInToICloud: Bool = false
    private(set) var error: CloudKitErrors? = nil
    private let container = CKContainer.default()
    
    func checkICloudStatus() async {
        do {
            let status = try await container.accountStatus()
            
            switch status {
            case .available:
                self.isSignedInToICloud = true
            case .couldNotDetermine:
                self.error = CloudKitErrors.iCloudAccountNotDetermined
            case .restricted:
                self.error = CloudKitErrors.iCloudAccountRestricted
            case .noAccount:
                self.error = CloudKitErrors.iCloudAccountNotFound
            case .temporarilyUnavailable:
                self.error = CloudKitErrors.iCloudAccountNotAvailable
            @unknown default:
                self.error = CloudKitErrors.iCloudAccontUnknown
            }
        } catch (let error) {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
