//
//  ContentView.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \User.name, ascending: true) ]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List {
                ForEach( users, id: \.self ) { user in
                    NavigationLink(destination: UserDetail(user: user) ) {
                        UserPreview(user: user)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Friends")
        }
    //TODO Not rewrite data!
    .onAppear(perform: loadData)
    }
    
    func loadData()
    {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([UserStruct].self, from: data) {
                    DispatchQueue.main.async {
                        for user in decoded {
                            if let _ = self.users.first(where: { $0.id == user.id } ) {
                                break
                            }
                            let newUser = User(context: self.moc)
                            newUser.id = user.id
                            newUser.name = user.name
                            newUser.isActive = user.isActive
                            newUser.age = user.age
                            newUser.about = user.about
                            newUser.address = user.address
                            newUser.registered = user.registered
                            newUser.email = user.email
                            newUser.company = user.company
                            
                            
                            for friend in user.friends
                            {
                                let newFriend = Friend(context: self.moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
                            print("\(newUser.name): \(newUser.friend.count)")
                            if self.moc.hasChanges {
                                try? self.moc.save()
                            }
                        }
                        //self.usersAll.users = decoded
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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return ContentView().environment(\.managedObjectContext, context)
    }
}
