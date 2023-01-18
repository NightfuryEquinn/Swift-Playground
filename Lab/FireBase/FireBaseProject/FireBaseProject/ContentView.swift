//
//  ContentView.swift
//  FireBaseProject
//
//  Created by YAP JIANN YANG on 18/01/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""

    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        Text("My restaurant: \(firestoreManager.restaurant)")
            .padding()
    }

    /*
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: { login() }) {
                Text("Sign in")
            }
        }
        .padding()
    }
          
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
     }
    */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
