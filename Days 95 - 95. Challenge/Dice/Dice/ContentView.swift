//
//  ContentView.swift
//  Dice
//
//  Created by Vlad Vrublevsky on 12.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TabView {
            PlayView()
            .environmentObject(user)
                .tag(0)
                .tabItem({
                    Image(systemName: "gamecontroller")
                    Text("Play")
                })
            ScoreView()
                .tag(1)
                .tabItem({
                    Image(systemName: "list.bullet")
                    Text("Score")
                })
            SettingsView()
                .environmentObject(user)
                .tag(2)
                .tabItem({
                    Image(systemName: "gear")
                    Text("Settings")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
