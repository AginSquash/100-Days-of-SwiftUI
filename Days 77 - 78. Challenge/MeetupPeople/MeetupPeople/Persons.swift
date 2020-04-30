//
//  Persons.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation
import SwiftUI

struct person: Identifiable {
    let id = UUID()
    let image: Image
    let name: String
}

class personsClass: ObservableObject {
    @Published var peopleArray = [person]()
}
