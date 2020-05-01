//
//  PersonPreview.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 01.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import MapKit

struct PersonPreview: View {
    var person: person
    
    var body: some View {
        HStack {
            Image(uiImage: person.image)
                .resizable()
                .frame(width: 100, height: self.getHeight(frameWidth: 100))
                .scaledToFit()
                .clipShape(Circle().inset(by: 1))
                .shadow(radius: 5)
            Text(person.name)
        }
    }
    
        func getHeight(frameWidth: CGFloat) -> CGFloat {

            let ratio = frameWidth / person.image.size.width
            return ratio * person.image.size.height
       
    }
}

struct PersonPreview_Previews: PreviewProvider {
    static var previews: some View {
        let coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
        return PersonPreview(person: person(image: UIImage(named: "3")! , name: "Paul", date: "12 03 2020", latitude: coordinate.latitude, longtitude: coordinate.longitude ))
            .previewLayout(.fixed(width: 400, height: 110))
    }
}
