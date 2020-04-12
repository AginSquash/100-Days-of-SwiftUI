//
//  ContentView.swift
//  Edutainment
//
//  Created by Vlad Vrublevsky on 12.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.all)
            List {
                Text("Text")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
