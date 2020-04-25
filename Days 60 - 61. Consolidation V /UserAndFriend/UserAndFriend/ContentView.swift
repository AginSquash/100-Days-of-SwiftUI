//
//  ContentView.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var usersAll: Users
    
    var body: some View {
        NavigationView {
            List {
                ForEach(usersAll.users) { user in
                    NavigationLink(destination: UserDetail(user: user) ) {
                        UserPreview(user: user)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Friends")
        }
    .onAppear(perform: loadData)
    }
    
    func loadData()
    {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.usersAll.users = decoded
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let users = Users()
        return ContentView().environmentObject(users)
    }
}
