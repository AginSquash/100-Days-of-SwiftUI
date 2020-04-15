//
//  AstronautView.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 15.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI



struct AstronautView: View {
    
    struct inCrew: Identifiable {
        let id: Int
        let role: String
        let LaunchDate: String
        
        var image: String {
            "apollo\(id)"
        }
        
        var name: String {
            "Apollo \(id)"
        }
    }
    
    let astronaut: Astronaut
    let missonsInCrew: [inCrew]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                    
                    HStack {
                        ForEach(self.missonsInCrew) { mission in
                            MissionPreview(id: mission.id ,role: mission.role, Date: mission.LaunchDate)
                        }
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, Missions: [Mission]){
        self.astronaut = astronaut
        
        var tempMissions = [inCrew]()
        for mission in Missions {
            if let participated = mission.crew.first(where: { $0.name == astronaut.id }) {
                tempMissions.append(inCrew(id: mission.id, role: participated.role, LaunchDate: mission.formattedLaunchDate))
            }
        }
        self.missonsInCrew = tempMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7], Missions: missions)
    }
}
