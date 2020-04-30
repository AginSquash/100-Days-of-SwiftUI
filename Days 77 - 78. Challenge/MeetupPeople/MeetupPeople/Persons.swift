//
//  Persons.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation
import SwiftUI

struct person: Codable {
    let image: Data
    let name: String
}

class personsClass: ObservableObject {
    @Published var peopleArray = [person]()
}
