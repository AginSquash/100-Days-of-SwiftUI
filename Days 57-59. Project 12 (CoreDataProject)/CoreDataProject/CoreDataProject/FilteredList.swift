//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Vlad Vrublevsky on 25.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

/*
struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors:
            [ NSSortDescriptor(keyPath: \Singer.lastName, ascending: true) ],
            predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}

*/
