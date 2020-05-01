//
//  PersonPreview.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 01.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct PersonPreview: View {
    var person: person
    
    var body: some View {
        HStack {
            person.image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle().inset(by: 1))
                .shadow(radius: 5)
                //.padding()
            Text( person.name)
        }
    }
}

struct PersonPreview_Previews: PreviewProvider {
    static var previews: some View {
        PersonPreview(person: person(image: Image("2"), name: "Paul"))
            .previewLayout(.fixed(width: 400, height: 110))
    }
}
