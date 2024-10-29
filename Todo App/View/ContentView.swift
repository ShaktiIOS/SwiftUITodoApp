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
    @State private var animatingButton: Bool = false
    
    @FetchRequest(
        entity: Todo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            ZStack {
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
                    }
                })
                
                // MARK: - NO TODO ITEMS
                if todos.isEmpty{
                    EmptyListView()
                }
            } //: ZSTACK
//            .sheet(isPresented: $showingAddTodoView){
//                AddTodoView().environment(\.managedObjectContext, self.viewContext)
//            }
            .overlay (
                ZStack {
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBAse")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//: BUTTON
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                ,alignment: .bottomTrailing
            )
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

// MARK: - PREVIEWS
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
