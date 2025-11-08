//
//  Anime+CoreDataProperties.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//
//

public import Foundation
public import CoreData


public typealias AnimeCoreDataPropertiesSet = NSSet

extension Anime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Anime> {
        return NSFetchRequest<Anime>(entityName: "Anime")
    }
    
    @NSManaged public var malId: Int32
    @NSManaged public var name: String?
    @NSManaged public var totalEpisodes: Int16
    @NSManaged public var releaseDate: Date?
    @NSManaged public var imageURL: String?
    @NSManaged public var myRating: Double
    @NSManaged public var dateAdded: Date?
    @NSManaged public var notes: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var watchStatus: String?
    @NSManaged public var studio: Studio?

}

extension Anime : Identifiable {

}
