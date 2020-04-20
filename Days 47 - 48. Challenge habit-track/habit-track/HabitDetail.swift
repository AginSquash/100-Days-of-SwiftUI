//
//  HabitDetail.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct HabitDetail: View {
    @EnvironmentObject var AllHabits: Habits
    var habit: HabitEvent
    
    @State private var isAdding = false
    @State private var amountValue = String()
    @State private var showAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Habit name") ) {
                Text(habit.name)
            }
            Section(header: Text("Habit description")) {
                Text(habit.description)
            }
            Section(header: Text("Total time in habit"))
            {
                Text("\(habit.totalTime) minutes")
                Button(action: { withAnimation { self.isAdding.toggle() } },
                       label: { Text("Add time") } )
            }

            if isAdding {
                Section {
                    HStack {
                        TextField("Time", text: $amountValue, onCommit: addTime)
                            .keyboardType(.numberPad)
                        Button(action: { self.addTime() }, label: { Image(systemName: "plus.circle") } )
                    }
                }
                .transition(.slide)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error!"), message: Text("Incorrect input!"), dismissButton: .default(Text("Ok")))
        }
        .navigationBarTitle("Habit", displayMode: .inline)
    }
    
    func addTime() {
        withAnimation {
            self.isAdding.toggle()
        }
        
        if self.amountValue == String() {
            return
        }
        
        if let addingValue = Int(self.amountValue) {
            if let index = self.AllHabits.habits.firstIndex(where: { $0.id == self.habit.id }) {
                
                self.AllHabits.habits[index].AddTime(time: addingValue)
                saveHabits(AllHabits: self.AllHabits)
                
            } else { fatalError("Not founded UUID") }
        } else {
            self.showAlert = true
        }
        
        self.amountValue = String()
    }
}

struct HabitDetail_Previews: PreviewProvider {

    
    static var previews: some View {
        HabitDetail(habit: HabitEvent(name: "Playing", description: "Playing the game", totalTime: 20)).environmentObject(Habits())
    }
}
