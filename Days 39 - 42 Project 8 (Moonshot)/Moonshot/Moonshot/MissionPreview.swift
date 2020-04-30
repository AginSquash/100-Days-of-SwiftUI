//
//  MissionPreview.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 15.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct MissionPreview: View {
    let id: Int
    let role: String
    let Date: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image("apollo\(self.id)")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                
            Text("Apollo \(self.id)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, alignment: .center)
            Text((self.Date))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            Text(self.role)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            }
            .padding()
            .frame(width: 150, height: 250, alignment: .top)
            .accessibility(addTraits: .isButton)
        }
}

struct MissionPreview_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        Group {
            MissionPreview(id: 7 ,role: "Pilot", Date: missions[0].formattedLaunchDate)
            MissionPreview(id: 8, role: "Pilot", Date: missions[1].formattedLaunchDate)
        }
        .previewLayout(.fixed(width: 200, height: 250) )
    }
}
