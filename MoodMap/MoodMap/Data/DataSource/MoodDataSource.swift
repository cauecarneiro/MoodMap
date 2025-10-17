//
//  MoodDataSource.swift
//  MoodMap
//
//  Created by Breno Marques on 16/10/25.
//

import CloudKit

class MoodDataSource {
    
    func fetchMoods() -> [MoodDTO] {
        let query = CKQuery(recordType: GlobalValues.recordType, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        var moods: [MoodDTO] = []
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {

            case .success(let record):
                guard let feeling = record["feeling"] as? String,
                      let description = record["description"] as? String,
                      let location = record["location"] as? CLLocation else { return }
                
                let mood = MoodDTO(feeling: feeling, description: description, location: location)
                moods.append(mood)
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
        
        queryOperation.queryResultBlock = { result in
           // Tentanto entender como implementar isso
        }
        
        CKContainer(identifier: GlobalValues.containerIdentifier).publicCloudDatabase.add(queryOperation)
        
        return moods
    }
    
    func saveMood(mood: MoodDTO) async {
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
