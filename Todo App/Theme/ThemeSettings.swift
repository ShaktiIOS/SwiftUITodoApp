//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Shakti on 02/12/24.
//

import SwiftUI

// MARK: - THEME CLASS

class ThemeSettings: ObservableObject{
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
