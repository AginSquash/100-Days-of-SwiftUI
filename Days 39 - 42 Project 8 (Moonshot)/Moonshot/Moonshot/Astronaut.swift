//
//  Astronaut.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 14.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

struct Astronaut : Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
