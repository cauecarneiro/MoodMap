//
//  CloudKitManager.swift
//  MoodMap
//
//  Created by Breno Marques on 14/10/25.
//

import Combine
import CloudKit
import CoreLocation

@MainActor
class CloudKitManager: ObservableObject {

    private let container = CKContainer(identifier: GlobalValues.containerIdentifier)
    @Published var moods: [MoodDTO] = []
    
    init() {
        fetchItems()
    }
    
    public func fetchItems() {
        let query = CKQuery(recordType: "MoodNote", predicate: NSPredicate(value: true))
        let queryOperation = CKQueryOperation(query: query)
        
        var items: [MoodDTO] = []
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
            case .success(let record):
                let title = record["title"] as? String ?? "Title"
                let feeling = record["feeling"] as? String ?? "Feeling"
                let description = record["description"] as? String ?? "Description"
                let location = record["location"] as? CLLocation ?? CLLocation()
                
                items.append(MoodDTO(title: title, feeling: feeling, description: description, location: location))
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] result in
            guard let self else { return }
            
            Task { @MainActor in self.moods = items }
        }
        
        container.publicCloudDatabase.add(queryOperation)
    }
    
    public func saveItem(mood: MoodDTO) async {
        let record = CKRecord(recordType: GlobalValues.recordType)
        record["title"] = mood.title as CKRecordValue
        record["feeling"] = mood.feeling as CKRecordValue
        record["description"] = mood.description as CKRecordValue
        record["location"] = mood.location as CKRecordValue
        
        do {
            let response = try await container.publicCloudDatabase.save(record)
            moods.append(mood)
            print("Record: \(response)")
        } catch {
            print("Erro: \(error.localizedDescription)")
        }
    }
}

extension CloudKitManager {
    static let container = CKContainer(identifier: GlobalValues.containerIdentifier)
}
