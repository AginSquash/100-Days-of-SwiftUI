//
//  Habits.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

class Habits: ObservableObject {
    private static let itemsKey = "habits"
    
    @Published var habits: [HabitEvent] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habits) { //not worked!
                UserDefaults.standard.set(encoded, forKey: Self.itemsKey)
            }
        }
    }
    
    init()
    {
        //self.habits = [HabitEvent(name: "Play", description: "Test decs", totalTime: 120), HabitEvent(name: "Eating", description: "Test decs2", totalTime: 20)]
        if let items = UserDefaults.standard.data(forKey: Self.itemsKey)
        {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitEvent].self, from: items)
            {
                self.habits = decoded
                return
            }
        }
        self.habits = [HabitEvent]()
    }
}
