//
//  MyAnimeCollectionApp.swift
//  MyAnimeCollection
//
//  Created by BORA on 10.11.2025.
//

import SwiftUI

@main
struct MyAnimeCollectionApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
