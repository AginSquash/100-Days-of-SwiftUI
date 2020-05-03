//
//  AuthView.swift
//  HotProspects
//
//  Created by Vlad Vrublevsky on 03.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct CheckAuth: View {
    
    var body: some View {
        Text("Check")
    }
    

}

struct AuthView: View {
    @State var isUnlocked = false
    
    var body: some View {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
