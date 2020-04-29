//
//  ContentView.swift
//  BucketList
//
//  Created by Vlad Vrublevsky on 28.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    var body: some View {
       ZStack {
        MapView(centerCoordinate: $centerCoordinate,selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: self.locations)
               .edgesIgnoringSafeArea(.all)
           Circle()
               .fill(Color.blue)
               .opacity(0.3)
               .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
         .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                } )
            }
        .sheet(isPresented: $showingEditScreen) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
