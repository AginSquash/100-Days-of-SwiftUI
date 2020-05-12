//
//  ScoreView.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI


struct ScorePreview: View {
    var score: Int16 = 6
    var maxScore: Int16 = 6
    var date: Date? = Date()
    
    var body: some View
    {
        HStack(alignment: .top) {
            Text("🎲")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text("Score: \(score)")
                    .font(.title)
                + Text(" of \(maxScore)")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(wrappedDate)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
    
    var wrappedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self.date ?? Date(timeIntervalSince1970: 0))
    }
}

struct ScoreView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceResult.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var diceResult: FetchedResults<DiceResult>
    
    var body: some View {
        NavigationView {
            VStack {
                List(diceResult, id: \.self) { result in
                    ScorePreview(score: result.score, maxScore: result.maxScore ,date: result.date)
                }
            }
            .navigationBarTitle("Your score history:", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ScoreView_Previews: PreviewProvider {
        @Environment(\.managedObjectContext) var moc
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //return  ScoreView().environment(\.managedObjectContext, context)
        return ScorePreview().previewLayout(.fixed(width: 400, height: 70))
    }
}
