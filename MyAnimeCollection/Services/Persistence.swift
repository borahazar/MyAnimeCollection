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
        
    }
}
