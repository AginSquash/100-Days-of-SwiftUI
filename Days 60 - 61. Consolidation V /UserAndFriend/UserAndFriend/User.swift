//
//  User.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

class Users: ObservableObject {
    @Published var users = [UserStruct]()
}

struct UserStruct: Codable, Identifiable {

    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int16
    
    let company: String
    let email: String
    let address: String
    let about: String
    let tags: [String]
    let registered: String
    
    var wrappedRegisterDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") 
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: registered) ?? Date()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    let friends: [FriendStruct]
}
