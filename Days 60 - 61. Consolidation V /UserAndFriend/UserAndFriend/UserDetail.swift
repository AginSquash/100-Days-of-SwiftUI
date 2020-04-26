//
//  UserDetail.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct UserDetail: View {
    //@EnvironmentObject var usersAll: Users
    @FetchRequest(entity: User.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \User.name, ascending: true) ]) var users: FetchedResults<User>
    
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
                ForEach(user.friends, id: \.self) { friend in
                    self.getFriendView(id: friend.id)
                }
            }
 
            /*
             Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            } */
            
        }
        .navigationBarTitle(Text("User"), displayMode: .inline)
        .frame( maxWidth: .infinity)
    }
    func getFriendView(id: UUID) -> some View {
        if let user = self.users.first(where: { $0.id == id }) {
            return NavigationLink(destination: UserDetail(user: user), label: { UserPreview(user: user) })
        } else {
            fatalError("Id fake")
        }
    }
    
}


struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: moc)
        user.id = UUID()
        user.isActive = true
        user.name = "Alford Rodriguez"
        user.about = "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n"
        user.age = 21
        user.company = "Gazprom"
        user.email = "email@example.com"
        user.address = "907 Nelson Street"
        user.registered = "2015-11-10T01:47:18-00:00"
        let friend = Friend(context: moc)
        friend.id = UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0") ?? UUID()
        friend.name = "Hawkins Patel"
        friend.user = user

        // Cannot preview this file = UserAndFriend.app may have crashed
        // Why????
        return UserDetail(user: user)
    }
}

