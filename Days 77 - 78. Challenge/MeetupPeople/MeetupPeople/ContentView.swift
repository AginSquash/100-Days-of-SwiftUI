//
//  ContentView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var persons = [person]()
    @State private var showEdit = false
    
    var body: some View {
        let personBinding = Binding<[person]>(
            get: { self.persons },
            set: {
                self.persons = $0
                self.save()
        })
        
    return NavigationView {
            List {
                ForEach(self.persons) { person in
                    NavigationLink(destination: PersonView(person: person)) {
                        PersonPreview(person: person)
                    }
                }
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
            EditView(persons: personBinding)
        }
        .onAppear(perform: load)
    }
    
    func save() {
        let personSaveble = convertToSaveble(persons: self.persons)
        Bundle.main.writeCustomData(data: personSaveble, file: "persons")
    }
    
    func load() {
        let personsLoaded = Bundle.main.readCustomData(file: "persons") ?? [personToSave]()
        self.persons = convertToPersons(personsSaveble: personsLoaded)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
