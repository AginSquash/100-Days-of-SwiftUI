//
//  MapView.swift
//  MeetupPeople
//
//  Created by Vlad Vrublevsky on 01.05.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    var annotation: MKPointAnnotation?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let annotation = self.annotation {
            mapView.centerCoordinate = annotation.coordinate
            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
            mapView.setCameraZoomRange(zoomRange, animated: true)
            mapView.addAnnotation(annotation)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // need add or remove annotations
        if uiView.annotations.count != 1 {
                if let annotation = self.annotation {
                    uiView.addAnnotation(annotation)
            }
        }
    }
    

    typealias UIViewType = MKMapView
}
