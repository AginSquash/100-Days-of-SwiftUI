//
//  AstronautPreview.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 15.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct AstronautPreview: View {
    let member: CrewMember
    
    var body: some View
    {
        VStack {
            Image(member.astronaut.id)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.primary, lineWidth: 1))
            
            Text(member.astronaut.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 150, alignment: .center)
            Text(member.role)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 160, height: 250, alignment: .top)
    }
}

struct AstronautPreview_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let member1: CrewMember = CrewMember(role: "Pilot", astronaut: astronauts.first!)
    static let member2: CrewMember = CrewMember(role: "Pilot", astronaut: astronauts[1])
    
    static var previews: some View {
        Group {
            AstronautPreview(member: member1)
            AstronautPreview(member: member2)
        }
        .previewLayout(.fixed(width: 160, height: 250))
    }
}
