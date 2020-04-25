//
//  UserPreview.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct OnlineIndicator: View {
    let online: Bool
    
    var body: some View
    {
        if online {
            return Image(systemName: "flame")
                .offset(y: -2)
                .foregroundColor(.orange)
        } else {
            return Image(systemName: "moon")
                .offset(y: -2)
                .foregroundColor(.primary)
        }
    }
}

struct UserPreview: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.name)
            Image(systemName: user.isActive ? "flame" : "moon")
                .offset(y: -2)
                .foregroundColor(user.isActive ? .orange : .gray)
            Spacer()
            //Text("\(user.age), \(user.company)")
        }
    }
}

struct UserPreview_Previews: PreviewProvider {
    static var previews: some View {
        UserPreview(user: User(id: UUID(), isActive: true, name: "Alford Rodriguez", age: 21, company: "Gazprom", email: "email@example.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "about", tags: ["cillum","consequat"], registered: "date", friends: [Friend(id: UUID(), name: "Pauline Dawson") ]))
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
