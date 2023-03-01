//
//  MyFirstMapApp.swift
//  MyFirstMap
//
//  Created by YIP ZI XIAN on 15/02/2023.
//

import SwiftUI

@main
struct MyFirstMapApp: App {
    @StateObject var myMapLocationManager = MyMapLocationManager()
    
    var body: some Scene {
        WindowGroup {
            MyMapView()
                .environmentObject(myMapLocationManager)
        }
    }
}
