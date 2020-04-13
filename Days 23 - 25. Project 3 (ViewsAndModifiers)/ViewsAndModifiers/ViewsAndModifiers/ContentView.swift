//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Vlad Vrublevsky on 02.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct BBCustom: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .shadow(radius: 5)
    }
}

extension View {
    func BBC_func() -> some View {
        self.modifier(BBCustom())
    }
}

struct ContentView: View {
        var body: some View {
            ZStack {
                Color.black
                Text("Text2").BBC_func()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
