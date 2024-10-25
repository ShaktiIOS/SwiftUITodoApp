//
//  ContentView.swift
//  Todo App
//
//  Created by Shakti on 24/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddTodoView: Bool = false

    @FetchRequest(
        entity: Todo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>

    // MARK: - BODY
    var body: some View {
        NavigationView {
            List{
                ForEach(todos, id: \.self) { todo in
                    HStack{
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                }//: FOREACH
                .onDelete(perform: deleteTodo)
            }//: LIST
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddTodoView){
                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
//                    Button(action: {
//                        self.showingAddTodoView.toggle()
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                    .sheet(isPresented: $showingAddTodoView){
//                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
//                    }
                }
            })
        }//: NAVIGATION
    }
    
    // MARK: - FUNCTIONS
    
    private func deleteTodo(at offsets: IndexSet){
        for index in offsets{
            let todo = todos[index]
            viewContext.delete(todo)
            
            do{
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - PREVIEWS
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
