//
//  ContentView.swift
//  WeSplit
//
//  Created by Vlad Vrublevsky on 30.03.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    
    @State private var numberOfPeopleTF = "2"
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalWithTips: Double {
        let tipPercent = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount.replacingOccurrences(of: ",", with: ".")) ?? 0
        let total = orderAmount / 100 * tipPercent + orderAmount
        
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeopleTF) ?? 2
        let tipPercent = Double(tipPercentages[tipPercentage])

        let orderAmount = Double(checkAmount.replacingOccurrences(of: ",", with: ".")) ?? 0
        
        let tipValue = orderAmount / 100 * tipPercent
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipPercentage==4 ? .yellow : .green)
                }
                
                Section(header: Text("Number of people")) {
                    TextField("", text: $numberOfPeopleTF)
                        .keyboardType(.numberPad)
    
                    /*
                    Picker("Number of people", selection: $numberOfPeople)
                    {
                        ForEach(2..<100)
                        {
                            Text("\($0) people")
                        }
                    } */
                }
                
                Section(header: Text("How much tip do you want to leave?") ) {
                    Picker("Tips perecent", selection: $tipPercentage)
                    {
                        ForEach(0..<tipPercentages.count)
                        {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total with tips"))
                {
                    Text("$\(totalWithTips, specifier: "%.2f")")
                        .foregroundColor(.red)
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
