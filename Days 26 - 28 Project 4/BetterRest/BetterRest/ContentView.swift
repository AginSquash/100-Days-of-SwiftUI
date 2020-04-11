//
//  ContentView.swift
//  BetterRest
//
//  Created by Vlad Vrublevsky on 04.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var amountSleep = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: amountSleep, coffee: Double(coffeAmount) )
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formater = DateFormatter()
            formater.timeStyle = .short
            
            /*
            alertMessage = formater.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
             */
            return formater.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            self.showingAlert = true
            return "Error"
        }
        
        //self.showingAlert = true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                    Text("When you want to wakeup?")
                        .font(.headline)
                        .foregroundColor(.black))
                {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                }
                Section(header: Text("Desired amount of sleep")
                .font(.headline))
                {

                     Stepper(value: $amountSleep, in: 4...12, step: 0.25) {
                        Text("\(amountSleep, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")
                .font(.headline))
                {
                    Picker("Cups of cofee", selection: $coffeAmount) {
                        ForEach (1..<7) {
                            if $0 == 1
                            {
                                Text("1 cup")
                            } else {
                                Text("\($0) cups")
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("Your ideal bedtime is: \(calculateBedtime())")
                }
            }
                .navigationBarTitle("BetterRest")
                /*.navigationBarItems(trailing:
                    Button(action: calculateBedtime) { //!!!
                        Text("Calculate")
                }) */
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage).font(.largeTitle), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
