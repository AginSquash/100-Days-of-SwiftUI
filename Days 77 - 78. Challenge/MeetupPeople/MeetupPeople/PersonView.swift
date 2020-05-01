//
//  PersonView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 01.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import MapKit

struct PersonView: View {
    @State private var annotation: MKPointAnnotation? = nil
    var person: person
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Text(self.person.name)
                    .font(.headline)
                    
                    Image(uiImage: self.person.image)
                        .resizable()
                        .frame(width: geometry.size.width, height: self.getHeight(frameWidth: geometry.size.width))
                        .scaledToFit()
                        .clipShape(Rectangle().inset(by: 5))
                        .shadow(radius: 5)
                    
                    Spacer(minLength: 40)
                    
                    if self.annotation != nil {
                        Text("Encountered \(self.person.date) at:")
                            .font(.headline)
                        MapView(annotation: self.annotation!  )
                        .frame(height: 300)
                        
                    }
                }
            }
        }
    .onAppear(perform: loadAnotation)
    }
    
    func loadAnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = person.name
        annotation.subtitle = "Meeting with" + person.name
        annotation.coordinate = CLLocationCoordinate2DMake(person.latitude, person.longtitude)
        
        self.annotation = annotation
    }
    
    func getHeight(frameWidth: CGFloat) -> CGFloat {
        let ratio = frameWidth / person.image.size.width
        return ratio * person.image.size.height
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: person(image: UIImage(named: "3")! , name: "Vlad", date: "12 03 2020", latitude: 0, longtitude: 0))
    }
}
