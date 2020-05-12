//
//  SettingsView.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var user: User
    
    @State private var maxValue = "6"
    @State private var selectedDiceCount = 0
    let possibleAmountfDices = ["1 dice", "2 dice", "3 dice", "4 dice" ]
    
    
    var body: some View {
    
    let maxBinding = Binding<String>(get: { self.maxValue }, set: { self.maxValue = $0; self.save() })
        
    let selectedBinding = Binding<Int>(get: { self.selectedDiceCount }, set: { self.selectedDiceCount = $0; self.save() })
        
    return NavigationView {
            Form {
                Section(header: Text("Maximum value on dice").font(.headline)) {
                    TextField("Default: 6", text: maxBinding)
                }
                
                Section(header: Text("Amount of dices").font(.headline)) {
                    Picker("Amount of dices", selection: selectedBinding) {
                        ForEach (0..<self.possibleAmountfDices.count) { i in
                            Text(self.possibleAmountfDices[i])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            .onAppear(perform: load)
            }
        .navigationBarTitle(Text("Settings"))
        }
    }
    
    func load() {
        self.maxValue = String(user.config.maxAmount)
        self.selectedDiceCount = user.config.diceCount - 1
    }
    
    func save() {
        let maxDiceValue = Int(maxValue) ?? 6
        user.config.maxAmount = maxDiceValue
        user.config.diceCount = selectedDiceCount + 1
        
        user.save()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        return SettingsView().environmentObject(user)
    }
}
