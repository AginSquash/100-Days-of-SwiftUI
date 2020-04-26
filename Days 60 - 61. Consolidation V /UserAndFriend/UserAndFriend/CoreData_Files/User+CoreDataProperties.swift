//
//  User+CoreDataProperties.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String
    @NSManaged public var address: String
    @NSManaged public var age: Int16
    @NSManaged public var id: UUID
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String
    @NSManaged public var registered: String
    @NSManaged public var email: String
    @NSManaged public var company: String
    @NSManaged public var friend: NSSet
    
    var wrappedRegisterDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: registered) ?? Date()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    public var friends: [Friend] {
        let set = friend as? Set<Friend> ?? []
        guard !set.isEmpty else {
            print("Set empety! (\(friend.count))")
            return []
        }
        print("friend.count: \(friend.count)")
        let newSet = set.sorted { $0.name < $1.name }
        print("newSet.count: \(newSet.count)")
        return newSet
    }

}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: Friend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: Friend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
