//
//  MissionView.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 14.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width * 0.7)
                    .padding(.top)
                    
                    Text(self.mission.description)
                    .padding()
                    
                    Spacer(minLength: 15)
                    
                    Text("Crew:")
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(self.astronauts, id:\.role) { crewMember in
                                NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                                    AstronautPreview(member: crewMember)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
