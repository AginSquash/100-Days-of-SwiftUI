//
//  ContentView.swift
//  Edutainment
//
//  Created by Vlad Vrublevsky on 12.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var MultiplierRange = 2
    
    var body: some View {
        VStack {
            Stepper("Range of variable ", value: $MultiplierRange, in: 2...12)
        }
    }
}

struct Game: View {
    var body: some View {
        Text("Game")
    }
}

struct ContentView: View {
    
    @State private var isSetting = true
    @State private var MultiplierRange = 2
    @State private var qeustionCount = 0
    
    let questionsAviable = ["5", "10", "20", "All"]
    var body: some View {
        NavigationView {
            ZStack {
                //LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .center)
                 //   .edgesIgnoringSafeArea(.all)
                VStack {
                    if isSetting {
                        VStack {
                            Stepper("Range of Multipliers: \(MultiplierRange)", value: $MultiplierRange, in: 2...12)
                            HStack {
                                Text("Number of question")
                                Spacer()
                            }
                            Picker(selection: $qeustionCount, label: Text("Number of question"), content: {
                                ForEach (0..<questionsAviable.count) {
                                    Text("\(self.questionsAviable[$0])")
                                }
                            })
                                .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .transition(.opacity)
                    } else {
                        Game()
                            .transition(.opacity)
                    }
                    Spacer()
                    Button(action: {  withAnimation { self.isSetting.toggle() } }, label: { Text("Play!") })
                    .padding()
                    
                }
            }
        .navigationBarTitle("Edutainment")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
