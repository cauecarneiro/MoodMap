//
//  CloudKitController.swift
//  MoodMap
//
//  Created by Breno Marques on 13/10/25.
//

import CloudKit

class CloudKitController<T: CKRecord> {
    private let container: CKContainer
    
    init() {
        self.container = CKContainer.default()
    }
    
    func save(item: T) {
        
    }
}

extension CKRecord {
    
}
