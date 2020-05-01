//
//  Persons.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct person: Identifiable, Comparable {
    
    let id = UUID()
    let image: UIImage
    let name: String
    let date: String
    
    // Make it to CLLocationCoordinate?
    let latitude: CLLocationDegrees
    let longtitude: CLLocationDegrees
    
    
    static func == (lhs: person, rhs: person) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: person, rhs: person) -> Bool {
        return lhs.name < rhs.name
    }
}

struct personToSave: Codable {
    let image: Data
    let name: String
    let date: String
    let latitude: CLLocationDegrees
    let longtitude: CLLocationDegrees
}

func convertToSaveble(persons: [person]) -> [personToSave] {
    var personsSaveble = [personToSave]()
    for person in persons {
        let newSave = personToSave(image: person.image.jpegData(compressionQuality: 0.8)!,
                                   name: person.name, date: person.date, latitude: person.latitude, longtitude: person.longtitude)
        personsSaveble.append(newSave)
    }
    return personsSaveble
}

func convertToPersons(personsSaveble: [personToSave]) -> [person] {
    var persons = [person]()
    for save in personsSaveble {
        let newPerson = person(image: UIImage(data: save.image)!, name: save.name, date: save.date,
                               latitude: save.latitude, longtitude: save.longtitude )
        persons.append(newPerson)
    }
    return persons
}
