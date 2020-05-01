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
    let image: UIImage
    let name: String
    let date: String
}

struct personToSave: Codable {
    let image: Data
    let name: String
    let date: String
}

func convertToSaveble(persons: [person]) -> [personToSave] {
    var personsSaveble = [personToSave]()
    for person in persons {
        let newSave = personToSave(image: person.image.jpegData(compressionQuality: 0.8)!,
                                   name: person.name, date: person.date)
        personsSaveble.append(newSave)
    }
    return personsSaveble
}

func convertToPersons(personsSaveble: [personToSave]) -> [person] {
    var persons = [person]()
    for save in personsSaveble {
        let newPerson = person(image: UIImage(data: save.image)!, name: save.name, date: save.date)
        persons.append(newPerson)
    }
    return persons
}
