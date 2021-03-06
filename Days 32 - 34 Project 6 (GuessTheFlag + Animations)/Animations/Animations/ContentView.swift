//
//  ContentView.swift
//  Animations
//
//  Created by Vlad Vrublevsky on 06.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//


import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .bottomTrailing),
            identity: CornerRotateModifier(amount: 0, anchor: .bottomTrailing) )
    }
}

struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            /*
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
            }
 */
            
            Rectangle()
                .frame(width: 50, height: 50, alignment: .center)
            .padding()
                .background(Color.red)
            .padding()
                .background(Color.blue)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
