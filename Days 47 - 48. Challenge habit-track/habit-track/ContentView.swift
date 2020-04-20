//
//  ContentView.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

func saveHabits(AllHabits: Habits) // fix for https://bugs.swift.org/browse/SR-12089
{
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(AllHabits.habits) {
        UserDefaults.standard.set(encoded, forKey: "habits")
    }
}

struct ContentView: View {
    @EnvironmentObject var AllHabits: Habits
    @State private var addNewHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(AllHabits.habits) { habit in
                    NavigationLink(
                        destination: HabitDetail(habit: habit),
                                   label: { HabitPreview(habit: habit) } )
                }
                .onDelete(perform: {
                    self.AllHabits.habits.remove(atOffsets: $0)
                    saveHabits(AllHabits: self.AllHabits)
                } )
            }
            .navigationBarTitle("Habit-Track")
            .navigationBarItems(leading: EditButton(), trailing:
            Button(action: { self.addNewHabit = true },
                   label: { Text("Add") }  )
            )
        .sheet(isPresented: $addNewHabit)
            {
                AddHabitView().environmentObject(self.AllHabits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Habits())
    }
}
