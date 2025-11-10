//
//  MainView.swift
//  MyAnimeCollection
//
//  Created by BORA on 10.11.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Tab("Search", systemImage: "text.page.badge.magnifyingglass") {
                SearchView()
            }
            
            Tab("Library", systemImage: "books.vertical") {
                LibraryView()
            }
        }
    }
}
