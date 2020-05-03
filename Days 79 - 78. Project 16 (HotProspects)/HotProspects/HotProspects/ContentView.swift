//
//  ContentView.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 02.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import LocalAuthentication


struct ContentView: View {
    
    var prospects = Prospects()
    @State var isUnlocked = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                TabView {
                    ProspectsView(filter: .none)
                        .tabItem {
                            Image(systemName: "person.3")
                            Text("Everyone")
                        }
                    
                    ProspectsView(filter: .contacted)
                    .tabItem {
                        Image(systemName: "checkmark.circle")
                        Text("Contacted")
                        }
                    
                    ProspectsView(filter: .uncontacted)
                    .tabItem {
                        Image(systemName: "questionmark.diamond")
                        Text("Uncontacted")
                        }
                    
                    MeView()
                        .tabItem {
                            Image(systemName: "person.crop.square")
                            Text("Me")
                        }
                }
                .environmentObject(prospects)
            } else {
                ZStack {
                    Text("Tap to login")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                .onAppear(perform: auth)
                .onTapGesture {
                    self.auth()
                }
            }
        }
    }
    
    func auth() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
