//
//  Mission.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 14.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
