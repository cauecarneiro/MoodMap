//
//  MoodDataSource.swift
//  MoodMap
//
//  Created by Breno Marques on 16/10/25.
//

import CloudKit

class MoodDataSource {
    
    func saveMood(mood: CreateMoodDTO) async {
        let newRecord = CKRecord(recordType: GlobalValues.recordType)
        newRecord["feeling"] = mood.feeling as CKRecordValue
        newRecord["description"] = mood.description as CKRecordValue
        newRecord["location"] = mood.location as CKRecordValue
        
        do {
            let response = try await CKContainer(identifier: GlobalValues.containerIdentifier).publicCloudDatabase.save(newRecord)
            print("Record: \(response)")
        } catch {
            print("Erro: \(error.localizedDescription)")
        }
    }
    
}
