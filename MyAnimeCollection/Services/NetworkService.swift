//
//  NetworkService.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case otherError
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "https://api.jikan.moe/v4"
    
    func searchAnime(query: String) async throws -> [AnimeData] {
        
        let urlString = "\(baseURL)/anime?q=\(query)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(JikanResponse.self, from: data)
            return response.data
        } catch {
            throw NetworkError.decodingError
        }
    }
}
