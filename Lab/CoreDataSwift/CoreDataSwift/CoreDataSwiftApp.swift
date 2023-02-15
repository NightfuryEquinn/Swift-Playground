//
//  CoreDataSwiftApp.swift
//  CoreDataSwift
//
//  Created by YIP ZI XIAN on 08/02/2023.
//

import SwiftUI

@main
struct To_DoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TasksView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
