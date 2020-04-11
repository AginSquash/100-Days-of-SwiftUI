//
//  ContentView.swift
//  WeSplit
//
//  Created by Vlad Vrublevsky on 30.03.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct CV_OLD: View {
    let studends = ["Vlad", "Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0
    
    @State private var tapCount = 0
    @State private var name = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text("Hello World")
                }
                Section {
                    Text("Hello world #2")
                    Text("Hello world #3")
                }
                Section {
                    Button("Tap Count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                Section {
                    TextField("Some text here ", text: $name)
                    Text("Your name: \(name)")
                }
                
                Section {
                    Picker("Selected your student", selection: $selectedStudent) {
                        ForEach(0 ..< studends.count) {
                            Text(self.studends[$0])
                        }
                    }
                    Text("You choose: Student \(studends[selectedStudent])")
                }
            }
            .navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
        }
    }
}

struct CV_old_Previews: PreviewProvider {
    static var previews: some View {
        CV_OLD()
    }
}
