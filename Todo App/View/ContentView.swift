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
    
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView: Bool = false
    
    // THEME
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    @FetchRequest(
        entity: Todo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ZStack {
                List{
                    ForEach(todos, id: \.self) { todo in
                        HStack{
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundStyle(self.colorize(priority: todo.priority ?? "Normal"))
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundStyle(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule()
                                        .stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                        } //: HSTACK
                        .padding(.vertical, 10)
                    }//: FOREACH
                    .onDelete(perform: deleteTodo)
                }//: LIST
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            self.showingSettingsView.toggle()
                        }) {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        }
                        .sheet(isPresented: $showingSettingsView){
                            SettingsView().environmentObject(self.iconSettings)
                        }
                        .tint(themes[self.theme.themeSettings].themeColor)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton().tint(themes[self.theme.themeSettings].themeColor)
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
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
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
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//: BUTTON
                    .tint(themes[self.theme.themeSettings].themeColor)
                    .sheet(isPresented: $showingAddTodoView){
                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
                    }
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
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
}

// MARK: - PREVIEWS
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
