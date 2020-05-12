//
//  UserConfig.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

struct UserConfig: Codable {
    var diceCount = 1
    var maxAmount = 6
}

class User: ObservableObject {
    @Published var config: UserConfig
    
    init() {
        if let data = UserDefaults().data(forKey: "config") {
            if let decoded = try? JSONDecoder().decode(UserConfig.self, from: data) {
                self.config = decoded
                return
            }
        }
        
        self.config = UserConfig()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(config) {
            UserDefaults().setValue(encoded, forKey: "config")
        }
    }
}
