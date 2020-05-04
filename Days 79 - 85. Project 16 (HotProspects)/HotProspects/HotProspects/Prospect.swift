//
//  Prospect.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var date: Date = Date()

    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name
    }
}

class Prospects: ObservableObject {
    
    static let saveKey = "SavedData"
    static let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(saveKey)
    
    @Published fileprivate(set) var people: [Prospect]
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func delete(personDelete: Prospect) {
        if let index = self.people.firstIndex(of: personDelete) {
            objectWillChange.send()
            self.people.remove(at: index)
            save()
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    init() {
        if let data = try? Data(contentsOf: Self.file) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded.sorted()
                return
            }
        }
        self.people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            do {
                try encoded.write(to: Self.file)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
