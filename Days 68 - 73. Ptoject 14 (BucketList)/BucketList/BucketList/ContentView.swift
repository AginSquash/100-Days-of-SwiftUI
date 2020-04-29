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
         .onAppear(perform: loadData)
         .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                } )
            }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        
        
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces.txt")

        do {
            let data = try Data(contentsOf: filename)
            let codableLocation = try JSONDecoder().decode([CodableMKPoint].self, from: data)
            self.locations = CodableMKPointToMKPointAnnotation(points: codableLocation)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
   func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces.txt")
            let codableLocation = MKPointAnnotationToCodableMKPoint(points: self.locations)
            let data = try JSONEncoder().encode(codableLocation)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Data saved")
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
