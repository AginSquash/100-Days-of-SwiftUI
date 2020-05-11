//
//  ContentView.swift
//  Flashzilla
//
//  Created by Vlad Vrublevsky on 04.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreHaptics
import Foundation

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var isTimeOver = false
    @State private var engine: CHHapticEngine?
    
    @State private var player: CHHapticPatternPlayer?
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                if differentiateWithoutColor {
                    VStack {
                        Spacer()

                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.removeCard(at: self.cards.count - 1)
                                }
                            }) {
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibility(label: Text("Wrong"))
                            .accessibility(hint: Text("Mark your answer as being incorrect."))
                            Spacer()

                            Button(action: {
                                withAnimation {
                                    self.removeCard(at: self.cards.count - 1)
                                }
                            }) {
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibility(label: Text("Correct"))
                            .accessibility(hint: Text("Mark your answer as being correct."))
                        }
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                    }
                }
                ZStack {
                    Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.75))
                        )
                        HStack {
                            Spacer()

                            Button(action: {
                                self.showingEditScreen = true
                            }) {
                                Image(systemName: "plus.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        }

                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index], removal:
                            { withAnimation { self.removeCard(at: index) }  })
                            .stacked(at: index, in: self.cards.count)
                            .allowsHitTesting(index == self.cards.count - 1)
                            .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
            .allowsHitTesting(timeRemaining > 0)
            if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
        }
        .alert(isPresented: $isTimeOver) {
            Alert(title: Text("Time is over!"), message: Text("Try again!"), dismissButton: .default(Text("Restart"), action: {
                    self.resetCards()
                
                    var events = [CHHapticEvent]()
                    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
                    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
                    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
                    events.append(event)
            }))
        }
        .onAppear(perform: resetCards)
        .onAppear(perform: prepareHaptic)
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
                EditCards()
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            if self.timeRemaining == 0 && self.isTimeOver == false {
                self.isTimeOver = true
                try? self.player?.start(atTime: 0)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
    }
    
    func removeCard(at index: Int) {
        guard cards.count >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func prepareHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        self.engine = try? CHHapticEngine()
        try? self.engine?.start()
        
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            self.player = player
        } catch {
             print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
