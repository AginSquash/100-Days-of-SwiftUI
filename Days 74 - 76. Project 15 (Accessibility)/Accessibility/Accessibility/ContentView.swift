//
//  ContentView.swift
//  Accessibility
//
//  Created by Vlad Vrublevsky on 30.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var rating = 3
    
    var body: some View {
       Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .padding()
            .accessibility(value: Text("\(rating) out of 5"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
