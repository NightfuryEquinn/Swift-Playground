//
//  MyMap.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 15/02/2023.
//

import Foundation
import MapKit
import SwiftUI

struct MyMap: UIViewRepresentable {
    @Binding var currentRegion: MKCoordinateRegion
    @Binding var currentAnnotation: MKPointAnnotation?
    
    // Create coordinator subclass of MyMap
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var map: MKMapView?
        var parent: MyMap
        
        init(_ parent: MyMap) {
            self.parent = parent
        }
        
        @objc func didLongPress(gesture: UITapGestureRecognizer) {
            if gesture.state == UIGestureRecognizer.State.began {
                // Drop Pin
                let touchedPoint = gesture.location(in: gesture.view)
                
                guard let touchedCoordinates = map?.convert(touchedPoint, toCoordinateFrom: map) else { return }
                
                // New Annotation
                let newAnnotation = MKPointAnnotation()
                
                newAnnotation.title = "Tap to see photos"
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: touchedCoordinates.latitude, longitude: touchedCoordinates.longitude)
                
                parent.currentAnnotation = newAnnotation
                
                // When the pin dropped, move closer to the location
                parent.currentRegion = MKCoordinateRegion(center: newAnnotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            } else {
                return
            }
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.setRegion(currentRegion, animated: true)
        
        // Long press gesture
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didLongPress(gesture:)))
        
        longPress.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPress)
        
        context.coordinator.map = map
    
        return map
    }
    
    func updateUIView(_ map: MKMapView, context: Context) {
        if currentAnnotation != nil {
            map.removeAnnotations(map.annotations)
            map.addAnnotation(currentAnnotation!)
        }
        map.setRegion(currentRegion, animated: true)
    }
    
    // Call the subclass coordinator itself
    func makeCoordinator() -> MyMap.Coordinator {
        Coordinator(self)
    }
}
