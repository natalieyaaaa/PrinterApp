//
//  CoreDataManager.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 04.04.2024.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataManager: ObservableObject {
    
    static var shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Documents")
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {print("Error of init CoreDataService: \(error!.localizedDescription)"); return}
        }
    }
    
    func updateEntity() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            persistentContainer.viewContext.rollback()
            print("Error updating CoreData entity: \(error.localizedDescription)")
        }
    }
    
    func saveEntity(image: Data, name: String, timeTaken: Date) {
        let entity = Document(context: persistentContainer.viewContext)
        entity.image = image
        entity.name = name
        entity.timeTaken = timeTaken
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            persistentContainer.viewContext.rollback()
            print("Error saving CoreData entity: \(error.localizedDescription)")
        }
    }
        
        func deleteEntity(entity: Document) {
            persistentContainer.viewContext.delete(entity)
            updateEntity()
            print("entity deleted")
        }
        
        func allEntities() -> [Document] {
            let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
            do {
                return try persistentContainer.viewContext.fetch(fetchRequest)
            } catch let error {
                print("Error getting all CoreData entities: \(error.localizedDescription)")
                return []
            }
        }
    }

// for previews
extension Document {
    
    static var example: Document {
        
        // Get the first PlanPoint from the in-memory Core Data store
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
}
