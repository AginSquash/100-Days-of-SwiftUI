//
//  UserPreview.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct UserPreview: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.name)
            Image(systemName: user.isActive ? "sun.max.fill" : "moon.fill")
                .foregroundColor(user.isActive ? .yellow : .gray)
            Spacer()
        }
    }
}

/*
struct UserPreview_Previews: PreviewProvider {
    static var previews: some View {
        UserPreview(user: UserStruct(id: UUID(), isActive: false, name: "Alford Rodriguez", age: 21, company: "Gazprom", email: "email@example.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "about", tags: ["cillum","consequat"], registered: "date", friends: [FriendStruct(id: UUID(), name: "Pauline Dawson") ]))
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
*/
