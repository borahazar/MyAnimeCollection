//
//  SearchView.swift
//  MyAnimeCollection
//
//  Created by BORA on 10.11.2025.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @State private var viewModel = AnimeSearchViewModel()
    @State private var searchQuery = ""
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search anime...", text: $searchQuery)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                    Button("Search") {
                        Task {
                            await viewModel.search(query: searchQuery)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(searchQuery.isEmpty)
                }
                .padding()
                
                if viewModel.animeData.isEmpty {
                    ContentUnavailableView(
                        "No Results",
                        systemImage: "magnifyingglass",
                        description: Text("Search for anime to get started")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                            ForEach(viewModel.animeData, id: \.malId) { anime in
                                AnimeCard(anime: anime, viewModel: viewModel, context: viewContext)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Find Anime")
        }
    }
}

struct AnimeCard: View {
    let anime: AnimeData
    let viewModel: AnimeSearchViewModel
    let context: NSManagedObjectContext
    
    @State private var showingSaveAlert = false
    @State private var saveError: SaveError?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: anime.images.jpg.largeImageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: 150, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(anime.title)
                .font(.headline)
                .lineLimit(2)
                .frame(width: 150, alignment: .leading)
            
            HStack {
                if let episodes = anime.episodes {
                    Text("\(episodes) eps")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if let score = anime.score {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                        Text(String(format: "%.1f", score))
                            .font(.caption)
                    }
                    .foregroundStyle(.orange)
                }
            }
            .frame(width: 150)
            
            Button {
                saveToCollection()
            } label: {
                Label("Add", systemImage: "plus.circle.fill")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
        }
        .alert("Save Result", isPresented: $showingSaveAlert) {
            Button("OK") { }
        } message: {
            if let error = saveError {
                switch error {
                case .duplicateAnime:
                    Text("This anime is already in your collection!")
                case .saveFailed:
                    Text("Failed to save. Please try again.")
                case .noContext:
                    Text("Database error occurred.")
                }
            } else {
                Text("Added to your collection!")
            }
        }
    }
    
    private func saveToCollection() {
        do {
            try viewModel.saveToCollection(animeData: anime, context: context)
            saveError = nil
            showingSaveAlert = true
        } catch let error as SaveError {
            saveError = error
            showingSaveAlert = true
        } catch {
            saveError = .saveFailed
            showingSaveAlert = true
        }
    }
}
