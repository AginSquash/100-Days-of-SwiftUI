//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Vlad Vrublevsky on 25.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    public var wrappedTitle: String {
        title ?? "Unknown titile"
    }
    public var wrappedDirector: String {
        director ?? "Unknown director"
    }
}
