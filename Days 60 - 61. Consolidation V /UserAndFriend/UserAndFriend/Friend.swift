//
//  Friend.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}
