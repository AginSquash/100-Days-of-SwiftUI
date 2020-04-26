//
//  UserPreview.swift
//  UserAndFriend
//
//  Created by Vlad Vrublevsky on 26.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import CoreData

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


struct UserPreview_Previews: PreviewProvider {
    
    static var previews: some View {
         let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let user = try! managedObjectContext.fetch(request).first as! User
        return UserPreview(user: user)
            .previewLayout(.fixed(width: 400, height: 50))
    }
}

