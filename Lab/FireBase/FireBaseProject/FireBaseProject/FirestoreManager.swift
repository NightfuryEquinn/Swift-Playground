//
//  FirestoreManager.swift
//  FireBaseProject
//
//  Created by YAP JIANN YANG on 18/01/2023.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    @Published var restaurant: String = ""
    
    let docData: [String: Any] = [
        "name": "Fiesta",
        "address": "1234 Rest St",
        "dateAdded": Timestamp(date: Date()),
    ]
    
    init() {
        fetchRestaurant()
        createRestaurant()
    }

    // Fetch / Read from database
    func fetchRestaurant() {
        let db = Firestore.firestore()

        let docRef = db.collection("Restaurants").document("PizzaMania")

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.restaurant = data["name"] as? String ?? ""
                }
            }
        }
    }
    
    // Create in database
    func createRestaurant() {
        let db = Firestore.firestore()

        let docRef = db.collection("Restaurants").document("Fiesta")

        docRef.setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

