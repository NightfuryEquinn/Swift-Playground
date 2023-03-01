//
//  MyMapLocationManager.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 15/02/2023.
//

import Foundation
import CoreLocation
import MapKit

class MyMapLocationManager: ObservableObject {
    // Show either the user's location or if don't know, show a default defined location
    @Published var currentRegion = MKCoordinateRegion(center: CLLocation(latitude: 48.864716, longitude: 2.349014).coordinate, latitudinalMeters: CLLocationDistance(10000), longitudinalMeters: CLLocationDistance(10000))
    
    // Queries the GPS data of the device the app runs on
    let userLocationManager = CLLocationManager()
    
    // Request for user permission
    func requestPermission() {
        switch userLocationManager.authorizationStatus {
        case .notDetermined:
            userLocationManager.requestAlwaysAuthorization()
        default:
            return
        }
    }
    
    // Call the function when launching the app
    // Ask user permission to access location
    init() {
        requestPermission()
        
        // Check if the location is taken or not
        guard let userLocation = userLocationManager.location?.coordinate else { return }
        
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(1000), longitudinalMeters: CLLocationDistance(1000))
    }
    
    // Zoom to the device's location when tap on the button
    func goToUserLocation() {
        guard let userLocation = userLocationManager.location?.coordinate else { return }
        
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(1000), longitudinalMeters: CLLocationDistance(1000))
    }
}
