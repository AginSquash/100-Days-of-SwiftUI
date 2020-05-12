//
//  PlayView.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct PlayView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var user: User
    
    @State private var scoreForDices = [Int](repeating: 0, count: 4)
    @State private var droppedScore = 0
    @State private var totalScore: Int = 0
    
    @State private var engine: CHHapticEngine?
    @State private var player: CHHapticPatternPlayer?
    
    var body: some View {
        VStack {
            
            if user.config.diceCount > 1 {
                Text("Total: \(totalScore)")
                    .font(.largeTitle)
                    .padding(.bottom, 25)
                    .transition(.opacity)
            }
            
            HStack {
                ForEach(0..<user.config.diceCount) { diceNumber in
                    Text( "\(self.scoreForDices[diceNumber])" )
                        .font(.largeTitle)
                        .padding()
                        .border(Color.red, width: 5)
                        .padding(5)
                        .border(Color.black, width: 5)
                        .padding(5)
                }
            }
            Button(action: { self.makeTrow() }, label: {
                ZStack {
                    Capsule()
                        .foregroundColor(Color.gray)
                        .padding(3)
                        .background(Color.black)
                        .clipShape(Capsule())
                    
                    Text("Trow! 🎲")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                .padding( user.config.diceCount > 1 ? .top : .bottom, 25)
                .frame(width: 200, height: 75, alignment: .center)
            } )
        }.onAppear(perform: prepareHaptic)
    }
    
    func prepareHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        

        var events = [CHHapticEvent]()
        
        let intesivity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intesivity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            self.engine = try CHHapticEngine()
            try self.engine?.start()
            let pattern = try CHHapticPattern(events: events, parameterCurves: [])
            self.player = try self.engine?.makePlayer(with: pattern)
        } catch {
            print("\(error.localizedDescription)")
        }
        
    }
    
    func makeTrow() {
        if let player = self.player {
            try? player.start(atTime: 0)
        }
        
        var totalScore = 0
        for i in 0..<user.config.diceCount {
            let score = Int.random(in: 1...user.config.maxAmount)
            self.scoreForDices[i] =  score
            totalScore += score
        }
        self.totalScore = totalScore
        let result = DiceResult(context: moc)
        result.id = UUID()
        result.date = Date()
        result.score = Int16(totalScore)
        result.maxScore = Int16( user.config.maxAmount * user.config.diceCount )
        try? self.moc.save()
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User()
        return PlayView().environment(\.managedObjectContext, context).environmentObject(user)
    }
}
