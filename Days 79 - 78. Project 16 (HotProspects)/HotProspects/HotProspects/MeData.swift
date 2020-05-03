//
//  MeData.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 03.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation

struct MeInfo: Codable {
    var name: String = "Anonymous"
    var emailAddress: String = "you@yoursite.com"
}

class MeShared: ObservableObject {
    static let saveKey = "MeData"
    static let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(saveKey)
    
    @Published var name: String = "Anonymous"
    @Published var emailAddress: String = "you@yoursite.com"
    
    init() {
        if let data = try? Data(contentsOf: Self.file) {
            if let decoded = try? JSONDecoder().decode(MeInfo.self, from: data) {
                self.name = decoded.name
                self.emailAddress = decoded.emailAddress
            }
        }
    }
    
    func save() {
        var meInfo = MeInfo()
        meInfo.name = self.name
        meInfo.emailAddress = self.emailAddress
        
        if let encoded = try? JSONEncoder().encode(meInfo) {
            do {
                try encoded.write(to: Self.file)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
