//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vlad Vrublevsky on 01.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var showScore = false
    @State private var scoreTitle = ""
    
    @State private var totalScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var animationDegree = 0.0
    @State private var isAnswered = false
    
    @State private var fadeOutOpacity = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30)
            {
                VStack {
                    Text("Tap the flag of")
                    Text(self.countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                
                
                ForEach(0..<3) { number in
                    Button (action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                }) {
                    FlagImage(image: Image(self.countries[number]) )
                        //.padding(CGFloat(8))
                        //.background(number == self.correctAnswer && self.isAnswered ? Color.green : nil)
                        //.animation(.default)
                    }
                        .rotation3DEffect(.degrees( number == self.correctAnswer && self.isAnswered ? 360.0 : 0.0), axis: (x: 0, y: 1, z: 0))
                        .opacity(self.fadeOutOpacity && !(self.correctAnswer == number) ? 0.25 : 1)
                        //.animation(.default)
                        //.rotation3DEffect(.degrees( self.animationDegree ), axis: (x: 1, y: 0, z: 0))
                    //.rotationEffect(.degrees( self.animationDegree ))
                        //.animation(.interactiveSpring())
                    
                    
                }
                Text("Your score: \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
            }
        }
    .alert(isPresented: $showScore) {
        Alert(title: Text(scoreTitle), message: Text("Your score \(totalScore)"), dismissButton: .default(Text("Continue")) {
            self.isAnswered = false
            self.fadeOutOpacity = false
            self.animationDegree = 0.0
            self.askQuestion()
            } )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore += 1

                self.animationDegree += 360
                self.isAnswered = true
                fadeOutOpacity = true
            
            
        } else {
            scoreTitle = "Wrong! This is flag of \(countries[number])"
            totalScore -= 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
