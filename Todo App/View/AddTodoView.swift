//
//  AddTodoView.swift
//  Todo App
//
//  Created by Shakti on 24/10/24.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    // MARK: - TODO NAME
                    TextField("TODO", text: $name)
                    
                    // MARK: - PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button("Save") {
                        if self.name != ""{
                            let todo = Todo(context: self.viewContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do{
                                try self.viewContext.save()
                                print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalide Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } //: FORM
            } //: VSTACK
            .navigationTitle("New Todo")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .alert(errorTitle, isPresented: $errorShowing) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
#Preview {
    AddTodoView()
}
