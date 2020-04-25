//
//  UserDetail.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct UserDetail: View {
    @EnvironmentObject var usersAll: Users
    let user: User
    
    var body: some View {
        Form {
            Section(header: Text("Name"))
            {
                UserPreview(user: user)
            }
            Section(header: Text("Info")) {
                HStack {
                    Text("Age:")
                        .fontWeight(.bold)
                    Text("\(user.age)")
                }
                HStack {
                    Text("Working in:")
                        .fontWeight(.bold)
                    Text("\(user.company)")
                }
                VStack(alignment: .leading) {
                    Text("About:")
                        .fontWeight(.bold)
                    Text("\(user.about)")
                }
                HStack {
                    Text("Registred:")
                        .fontWeight(.bold)
                    Text("\(user.wrappedRegisterDate)")
                }
            }
            Section(header: Text("Contact")) {
                Text(user.email)
                Text(user.address)
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    self.getFriendView(id: friend.id)
                }
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            
        }
        .navigationBarTitle(Text("User"), displayMode: .inline)
        .frame( maxWidth: .infinity)
    }
    func getFriendView(id: UUID) -> some View {
        if let user = self.usersAll.users.first(where: { $0.id == id }) {
            return NavigationLink(destination: UserDetail(user: user), label: { UserPreview(user: user) })
        } else {
            fatalError("Id fake")
        }
    }
    
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        let about = "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n"
        
        return UserDetail(user: User(id: UUID(), isActive: true, name: "Alford Rodriguez", age: 21, company: "Gazprom", email: "email@example.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: about, tags: ["cillum","consequat"], registered: "date", friends: [Friend(id: UUID(), name: "Pauline Dawson") ]))
    }
}
