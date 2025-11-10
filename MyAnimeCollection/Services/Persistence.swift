//
//  Persistence.swift
//  MyAnimeCollection
//
//  Created by BORA on 10.11.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyAnimeCollection")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
