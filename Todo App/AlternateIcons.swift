//
//  AlternateIcons.swift
//  Todo App
//
//  Created by Shakti on 30/11/24.
//

import Foundation
import UIKit

// MARK: - ALTERNATE ICONS

class IconNames:ObservableObject{
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        
        if let currentIcon = UIApplication.shared.alternateIconName{
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames(){
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String:Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String:Any] {
            for(_,value) in alternateIcons{
                guard let iconList = value as? Dictionary<String,Any> else {return}
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else {return}
                guard let icon = iconFiles.first else{return}
                
                iconNames.append(icon)
            }
        }
    }
}
