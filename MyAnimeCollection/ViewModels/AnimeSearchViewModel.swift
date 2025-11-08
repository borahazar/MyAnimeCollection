//
//  AnimeSearchViewModel.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//

import Foundation
import CoreData
import Observation


enum SaveError: Error {
    case duplicateAnime
    case saveFailed
    case noContext
}

@Observable
class AnimeSearchViewModel {
    var animeData: [AnimeData] = []
    var networkError: NetworkError?
    
    func search(query: String) async {
        do {
            let results = try await NetworkService.shared.searchAnime(query: query)
            animeData = results
            networkError = nil
        } catch NetworkError.invalidURL {
            networkError = NetworkError.invalidURL
        } catch NetworkError.noData {
            networkError = NetworkError.noData
        } catch NetworkError.decodingError {
            networkError = NetworkError.decodingError
        } catch {
            networkError = NetworkError.otherError
        }
    }
    
    func saveToCollection(animeData: AnimeData, context: NSManagedObjectContext) throws {
        
        let fetchRequest = Anime.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "malId == %d", animeData.malId)
        
        let existingAnime = try? context.fetch(fetchRequest)
        if let existing = existingAnime, !existing.isEmpty {
            throw SaveError.duplicateAnime
        }
        
        let anime = Anime(context: context)
        anime.watchStatus = nil
        anime.isFavorite = false
        anime.myRating = 0.0
        anime.notes = nil
        anime.malId = Int32(animeData.malId)
        anime.name = animeData.title
        anime.totalEpisodes = Int16(animeData.episodes ?? 0)
        anime.imageURL = animeData.images.jpg.largeImageUrl
        
        if let dateString = animeData.aired.from {
            let formatter = ISO8601DateFormatter()
            anime.releaseDate = formatter.date(from: dateString)
        }
        
        if let studioName = animeData.studios.first?.name {
            let studio = Studio(context: context)
            studio.name = studioName
            studio.country = "Japan"
            anime.studio = studio
        }
        
        anime.dateAdded = Date()
        
        do {
            try context.save()
        } catch {
            throw SaveError.saveFailed
        }
    }
}
