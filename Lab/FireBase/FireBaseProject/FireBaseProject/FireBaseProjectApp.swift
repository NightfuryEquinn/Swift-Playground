//
//  FireBaseProjectApp.swift
//  FireBaseProject
//
//  Created by YAP JIANN YANG on 18/01/2023.
//

import SwiftUI
import Firebase

@main
struct FireBaseProjectApp: App {
    
    @StateObject var firestoreManager = FirestoreManager()
    // Primary copy to allow others to receive
    
    /*
    init() {
        fetchRestaurant()
    }
    */
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}
