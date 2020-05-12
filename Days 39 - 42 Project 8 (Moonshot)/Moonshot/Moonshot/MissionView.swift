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

struct ImageMod: ViewModifier {
    let minY: CGFloat
    func body(content: Content) -> some View {
        let moved = minY
        if moved == 88 {
            return content.scaleEffect( 1 ).animation(.none)
        }
        
        if moved > 110 {
            return content.scaleEffect( 1.25 ).animation(.default)
        }
        
        if moved > 66
        {
            let scale = moved / 88
            return content.scaleEffect( scale ).animation(.default)
        } else {
            return content.scaleEffect( 0.75 ).animation(.default)
        }
    }
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    let Missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                    VStack {
                        
                        GeometryReader { geo in
                            Image(decorative: self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.7 )
                                .position(x: geometry.frame(in: .global).midX, y: geo.frame(in: .local).midY)
                                .modifier(ImageMod(minY: geo.frame(in: .global).minY))
                                .onTapGesture {
                                        print(geo.frame(in: .global).minY)
                                }
                        }
                        
                        
                        Text("Launch Date: \(self.mission.formattedLaunchDate)")
                            .font(.headline)
                        
                        Text(self.mission.description)
                            .padding(.top)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 15)
                        
                        Text("Crew:")
                            .font(.title)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(self.astronauts, id:\.role) { crewMember in
                                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, Missions: self.Missions)) {
                                        AstronautPreview(member: crewMember)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        //Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    
    init(mission: Mission, astronauts: [Astronaut], Missions: [Mission]) {
        self.mission = mission
        self.Missions = Missions
        
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
        MissionView(mission: missions[0], astronauts: astronauts, Missions: missions)
    }
}
