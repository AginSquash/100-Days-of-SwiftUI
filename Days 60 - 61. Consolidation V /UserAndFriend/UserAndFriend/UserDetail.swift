//
//  UserDetail.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Spacer(minLength: 25)
                UserPreview(user: user)
                Text("Age: \(user.age)")
                Text("Working in: \(user.company)")
                Text("About: \(user.about)")
            }
        }
        .padding()
        .frame( maxWidth: .infinity)
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        let about = "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n"
        
        return UserDetail(user: User(id: UUID(), isActive: true, name: "Alford Rodriguez", age: 21, company: "Gazprom", email: "email@example.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: about, tags: ["cillum","consequat"], registered: "date", friends: [Friend(id: UUID(), name: "Pauline Dawson") ]))
    }
}
