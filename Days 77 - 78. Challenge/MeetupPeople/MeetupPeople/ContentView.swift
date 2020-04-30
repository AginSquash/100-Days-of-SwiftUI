//
//  ContentView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var persons = personsClass()
    
    @State private var showEdit = false
    
    var body: some View {
        NavigationView {
            List {
                Text("123")
                
            }
            .navigationBarItems(trailing: Button(action:  { self.showEdit = true }) {
                Image(systemName: "plus")
                    .padding()
                    .scaledToFill()
                .accessibility(label: Text("Add new friend"))
            })
        .navigationBarTitle("MeetupPeople")
        }
        .sheet(isPresented: $showEdit) {
            EditView(persons: self.persons)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
