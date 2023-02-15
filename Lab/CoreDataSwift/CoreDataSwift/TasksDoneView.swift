//
//  TasksDoneVIew.swift
//  CoreDataSwift
//
//  Created by YIP ZI XIAN on 08/02/2023.
//

import SwiftUI

struct TasksDoneView: View {
    var rowHeight: CGFloat = 50
    
    // Access viewContext to fetch and save data
    @Environment(\.managedObjectContext) var viewContext
    
    // Target entity
    // Fetch data sorted by createdAt with NSSortDescriptor
    // Show undone tasks only
    // Default animation when added or removed
    @FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.createdAt, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", true), animation: .default)
    
    // Declare variable for fetched data
    var fetchedItems: FetchedResults<ToDoItem>
    
    var body: some View {
        List {
            ForEach(fetchedItems, id: \.self) {item in
                HStack {
                    Text(item.taskTitle ?? "Empty")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }
                .frame(height: rowHeight)
            }
            .onDelete(perform: removeItems)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Tasks Done"))
        .navigationBarItems(trailing: EditButton())
    }
    
    // Accepts a set of indices since multiple items can be deleted at once
    // Cycles through every index in this set of indices
    // Find the corresponding ToDoItem in fetchedItems
    private func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = fetchedItems[index]
            viewContext.delete(item)
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct TasksDoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TasksDoneView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
