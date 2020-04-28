//
//  MapView.swift
//  BucketList
//
//  Created by Vlad Vrublevsky on 29.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
           let mapView = MKMapView()
           return mapView
       }

       func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
       }
}
