//
//  Studio+CoreDataProperties.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//
//

public import Foundation
public import CoreData


public typealias StudioCoreDataPropertiesSet = NSSet

extension Studio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Studio> {
        return NSFetchRequest<Studio>(entityName: "Studio")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var animes: NSSet?

}

// MARK: Generated accessors for animes
extension Studio {

    @objc(addAnimesObject:)
    @NSManaged public func addToAnimes(_ value: Anime)

    @objc(removeAnimesObject:)
    @NSManaged public func removeFromAnimes(_ value: Anime)

    @objc(addAnimes:)
    @NSManaged public func addToAnimes(_ values: NSSet)

    @objc(removeAnimes:)
    @NSManaged public func removeFromAnimes(_ values: NSSet)

}

extension Studio : Identifiable {

}
