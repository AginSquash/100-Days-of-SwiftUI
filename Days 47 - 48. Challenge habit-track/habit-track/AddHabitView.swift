//
//  AddHabitView.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var AllHabits: Habits
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = String()
    @State private var description = String()
    @State private var startedTime = String()
    var body: some View {
        Form {
            Section(header: Text("Name of habit").font(.headline).padding(.top)) {
                TextField("Name" ,text: $name)
            }
            Section(header: Text("Description").font(.headline)) {
                TextField("Description" ,text: $description)
            }
            Section(header: Text("Started time").font(.headline)) {
                TextField("Time" ,text: $startedTime)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button(action: save, label: { Text("Save") })
                    Spacer()
                }
            }
        }

    }
    
    func save()
    {
        let habit = HabitEvent(name: self.name, description: self.description, totalTime: Int(self.startedTime) ?? 0)
        self.AllHabits.habits.append(habit)
        saveHabits(AllHabits: self.AllHabits)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView().environmentObject(Habits())
    }
}
