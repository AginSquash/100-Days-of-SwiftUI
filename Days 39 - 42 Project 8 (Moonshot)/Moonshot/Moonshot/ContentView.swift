//
//  ContentView.swift
//  Moonshot
//
//  Created by Vlad Vrublevsky on 13.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var sortByName = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $sortByName.animation()) {
                    Text("Sort by name")
                        .font(.headline)
                }
                .padding()
                
                List(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, Missions: self.missions)) {
                        Image(mission.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                        
                        VStack (alignment: .leading) {
                            Text(mission.displayName)
                                .font(.title)
                            Text( self.sortByName ? self.getAstronautsName(crews: mission.crew) : mission.formattedLaunchDate)
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
    
    func getAstronautsName(crews: [Mission.CrewRole]) -> String
    {
        var memberString = String()
        for crew in crews {
            if let member = astronauts.first(where: { $0.id == crew.name } ) {
                memberString.append( "\(member.name), " )
            }
        }
        return String (memberString.dropLast(2))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
