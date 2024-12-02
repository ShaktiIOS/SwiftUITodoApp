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
    
    // THEME
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    // MARK: - BODY
    var body: some View {
        NavigationStack{
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - TODO NAME
                    TextField("TODO", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(.rect(cornerRadius: 9))
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
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
                    } //: SAVE BUTTON
                    .font(.system(size: 24,weight: .bold, design: .default))
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(themes[self.theme.themeSettings].themeColor)
                    .clipShape(.rect(cornerRadius: 9))
                    .foregroundStyle(Color.white)
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
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
        .tint(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
#Preview {
    AddTodoView()
}
