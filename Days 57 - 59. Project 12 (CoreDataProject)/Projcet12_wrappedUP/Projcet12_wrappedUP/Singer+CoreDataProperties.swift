//
//  Singer+CoreDataProperties.swift
//  Projcet12_wrappedUP
//
//  Created by Vlad Vrublevsky on 25.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    public var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    public var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}
