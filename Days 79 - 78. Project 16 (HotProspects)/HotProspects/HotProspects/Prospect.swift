//
//  Prospect.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
