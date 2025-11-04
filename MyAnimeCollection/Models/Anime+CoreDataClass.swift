//
//  Anime+CoreDataClass.swift
//  MyAnimeCollection
//
//  Created by BORA on 4.11.2025.
//
//

public import Foundation
public import CoreData

public typealias AnimeCoreDataClassSet = NSSet

@objc(Anime)
public class Anime: NSManagedObject {
    static func search(byName name: String, context: NSManagedObjectContext) -> [Anime] {
        let request = Anime.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        let results = try? context.fetch(request)
        return results ?? []
    }
    static func favorites(context: NSManagedObjectContext) -> [Anime] {
        let request = Anime.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == true")
        let results = try? context.fetch(request)
        return results ?? []
    }
    static func allAnime(sortedBy sortDescriptors: [NSSortDescriptor], context: NSManagedObjectContext) -> [Anime] {
        let request = Anime.fetchRequest()
        request.sortDescriptors = sortDescriptors
        let result = try? context.fetch(request)
        return result ?? []
    }
    func setWatchStatus(to status: String) {
        self.watchStatus = status
    }
    func setRating(to rating: Double) {
        self.myRating = rating
    }
    func setFavorite() {
        self.isFavorite.toggle()
    }
    func setNotes(notes: String) {
        self.notes = notes
    }
}
