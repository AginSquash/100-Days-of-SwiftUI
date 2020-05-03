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
    
    func delete(at index: IndexSet){
        objectWillChange.send()
        self.people.remove(atOffsets: index)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sortByName() {
        objectWillChange.send()
        self.people = self.people.sorted()
    }
    
    func sortByDate() {
        objectWillChange.send()
        self.people = self.people.sorted(by: { $0.date < $1.date })
    }
    
    init() {
        if let data = try? Data(contentsOf: Self.file) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                sortByName()
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
