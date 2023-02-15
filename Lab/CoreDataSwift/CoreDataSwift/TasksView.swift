//
//  TasksView.swift
//  CoreDataSwift
//
//  Created by YIP ZI XIAN on 08/02/2023.
//

import SwiftUI

struct TasksView: View {
    var rowHeight: CGFloat = 50
    
    // Access viewContext to fetch and save data
    @Environment(\.managedObjectContext) var viewContext
    
    // Target entity
    // Fetch data sorted by createdAt with NSSortDescriptor
    // Show undone tasks only
    // Default animation when added or removed
    @FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.createdAt, ascending: false)], predicate: NSPredicate(format: "taskDone = %d", false), animation: .default)
    
    // Declare variable for fetched data
    var fetchedItems: FetchedResults<ToDoItem>
    
    // Enable modify values in struct
    @State var newTaskTitle = ""
    @State var searchText = ""
    @State var searching = false
    
//    var sampleTask = [
//        "Task One", "Task Two", "Task Three"
//    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText, searching: $searching)
                
                List {
                    if searching {
                        ForEach(fetchedItems.filter({ (item: ToDoItem) -> Bool in
                            return item.taskTitle!.hasPrefix(searchText) || searchText == ""
                        }), id: \.self) { searchResult in
                            HStack {
                                Text(searchResult.taskTitle ?? "Empty")
                                Spacer()
                                Button(action: {
                                    markTask(at: fetchedItems.firstIndex(of: searchResult)!)
                                }) {
                                    Image(systemName: "circle")
                                        .imageScale(.large)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(height: rowHeight)
                    } else {
                        ForEach(fetchedItems, id: \.self) { item in
                            HStack {
                                Text(item.taskTitle ?? "Empty")
                                Spacer()
                                Button(action: {
                                    // Get index of the task
                                    markTask(at: fetchedItems.firstIndex(of: item)!)
                                }) {
                                    Image(systemName: "circle")
                                        .imageScale(.large)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(height: rowHeight)
                        .gesture(DragGesture()
                                    .onChanged({ _ in
                                        UIApplication.shared.dismissKeyboard()
                                    })
                                ) // Hide the keyboard when scrolling through search result
                        
                        HStack {
                            TextField("Add task...", text: $newTaskTitle, onCommit: {
                                saveTask()
                            })
                            Button(action: {
                                saveTask()
                            }) {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                            }
                        }
                        .frame(height: rowHeight)
                        
                        NavigationLink(destination: TasksDoneView()) {
                            Text("Tasks done")
                                .frame(height: rowHeight)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle(searching ? "Searching" : "To-Do")
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Save Task Function
    func saveTask() {
        // Avoid empty title
        guard self.newTaskTitle != "" else {
            return
        }
        
        // Fixed attribute of ToDoItem
        let newToDoItem = ToDoItem(context: viewContext)
        
        newToDoItem.taskTitle = newTaskTitle
        newToDoItem.createdAt = Date()
        newToDoItem.taskDone = false
        
        // Do-Try-Catch Error
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        // Clear Input
        newTaskTitle = ""
    }
    
    // Mark Task As Done Function
    func markTask(at index: Int) {
        let item = fetchedItems[index]
        
        item.taskDone = true
        
        // Do-Try-Catch Error
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// Hide the keyboard manually
extension UIApplication {
    func dismissKeyboard() {
        // The "Control" that currently commands the keyboard should stop commanding
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        // Update preview content
        TasksView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
