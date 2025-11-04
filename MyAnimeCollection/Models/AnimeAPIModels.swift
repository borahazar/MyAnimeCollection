//
//  AnimeAPIModels.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//

import Foundation

struct JikanResponse: Codable {
    let data: [AnimeData]
}

struct AnimeData: Codable {
    
    let malId: Int
    let title: String
    let episodes: Int?
    let score: Double?
    let images: AnimeImages
    let studios: [StudioData]
    let aired: Aired
    
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case title
        case episodes
        case score
        case images
        case studios
        case aired
    }
}

struct AnimeImages: Codable {
    let jpg: ImageURLs
}

struct ImageURLs: Codable {
    let largeImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case largeImageUrl = "large_image_url"
    }
}

struct StudioData: Codable {
    let name: String
}

struct Aired: Codable {
    let from: String?
}
