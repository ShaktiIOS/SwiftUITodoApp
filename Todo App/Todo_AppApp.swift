//
//  Todo_AppApp.swift
//  Todo App
//
//  Created by Shakti on 24/10/24.
//

import SwiftUI

@main
struct Todo_AppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var iconNames = IconNames()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(iconNames)
        }
    }
}
