//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Vlad Vrublevsky on 25.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
