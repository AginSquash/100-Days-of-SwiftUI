//
//  PlayView.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct PlayView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var scoreForDices = [Int](repeating: 0, count: 4)
    @State private var totalDice = 4
    @State private var droppedScore = 0
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<totalDice) { diceNumber in
                    Text( "\(self.scoreForDices[diceNumber])" )
                        .font(.largeTitle)
                        .padding()
                        .border(Color.red, width: 5)
                        .padding(5)
                        .border(Color.black, width: 5)
                        .padding()
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
                .frame(width: 200, height: 75, alignment: .center)
            } )
        }
    }
    
    func makeTrow() {
        var totalScore = 0
        for i in 0..<totalDice {
            let score = Int.random(in: 1...6)
            self.scoreForDices[i] = score
            totalScore += score
        }
        let result = DiceResult(context: moc)
        result.id = UUID()
        result.date = Date()
        result.score = Int16(totalScore)
        try? self.moc.save()
        print("saved")
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return PlayView().environment(\.managedObjectContext, context)
    }
}
