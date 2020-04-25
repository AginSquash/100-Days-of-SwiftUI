//
//  ContentView.swift
//  Projcet12_wrappedUP
//
//  Created by Vlad Vrublevsky on 25.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var isSletter = true
    var body: some View {
        VStack {
            
            FilteredList(filter: isSletter ? "S" : "L", for: "lastName", with: .beginsWith)
            
            HStack {
                Button("Add") {
                    let newSinger = Singer(context: self.moc)
                    newSinger.firstName = "Taylor"
                    newSinger.lastName  = "S0ift"
                    
                    let newSinger2 = Singer(context: self.moc)
                    newSinger2.firstName = "John"
                    newSinger2.lastName  = "L1ennon"
                    
                    try? self.moc.save()
                }
                Spacer()
                Button("Change Letter") {
                    self.isSletter.toggle()
                }
            }
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       return ContentView().environment(\.managedObjectContext, context)
    }
}
