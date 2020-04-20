//
//  HabitPreview.swift
//  habit-track
//
//  Created by Vlad Vrublevsky on 20.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct HabitPreview: View {
    let habit: HabitEvent
    
    var body: some View {
        HStack {
            Text(habit.name)
            Spacer()
            Text("Total: \(habit.totalTime) min")
                .foregroundColor(.secondary)
        }
    .padding()
    }
}

struct HabitPreview_Previews: PreviewProvider {
    static var previews: some View {
        HabitPreview(habit: HabitEvent(name: "Name", description: "description", totalTime: 20))
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
