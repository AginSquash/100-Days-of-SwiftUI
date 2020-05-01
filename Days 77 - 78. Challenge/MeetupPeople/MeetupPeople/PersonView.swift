//
//  PersonView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 01.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    var person: person
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                Text(self.person.name)
                .font(.headline)
                
                Image(uiImage: self.person.image)
                    .resizable()
                    .frame(width: geometry.size.width, height: self.getHeight(frameWidth: geometry.size.width))
                    .scaledToFit()
                    .clipShape(Rectangle().inset(by: 5))
                    .shadow(radius: 5)

                Text("Added: \(self.person.date)")
                
                Spacer()
            }
        }
    }
    
    func getHeight(frameWidth: CGFloat) -> CGFloat {
        let ratio = frameWidth / person.image.size.width
        return ratio * person.image.size.height
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: person(image: UIImage(named: "3")! , name: "Vlad", date: "12 03 2020"))
    }
}
