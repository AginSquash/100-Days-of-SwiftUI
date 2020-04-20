//
//  HabitEvent.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

struct HabitEvent: Codable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    var totalTime: Int
    
    init(id: UUID, name: String, description: String, totalTime: Int)
    {
        self.id = id
        self.name = name
        self.description = description
        self.totalTime = totalTime
    }
    
    init(name: String, description: String, totalTime: Int) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.totalTime = totalTime
    }
    
    mutating func AddTime(time: Int)
    {
        self.totalTime += time
    }
}
