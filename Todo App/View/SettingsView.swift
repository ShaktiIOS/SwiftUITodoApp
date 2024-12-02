//
//  SettingsView.swift
//  Todo App
//
//  Created by Shakti on 30/11/24.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    // THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    @State private var isThemeChanged: Bool = false
    
    // MARK: - FUNCTIONS
    func resizedImage(named imageName: String, size: CGSize) -> UIImage? {
        guard let originalImage = UIImage(named: imageName) else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, originalImage.scale)
        originalImage.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack{
            VStack(alignment: .center,spacing: 0){
                
                // MARK: - FORM
                Form{
                    // MARK: - SECTION 1
                    Section{
                        Picker(selection: $iconSettings.currentIndex) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack{
                                    if let resizedImage = resizedImage(named: self.iconSettings.iconNames[index] ?? "Blue", size: CGSize(width: 44, height: 44)) {
                                        Image(uiImage: resizedImage)
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    
                                    Spacer().frame(width: 50)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }
                                .padding(3)
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundStyle(Color.primary)
                                }
                                .frame(width: 44, height: 44)
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                            } //: LABEL
                        } //: PICKER
                        .onReceive([self.iconSettings.currentIndex].publisher.first()){ value in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value{
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! You have changed the app icon.")
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Choose the app icon")
                    } //: SECTION 1
                    .padding(.vertical, 1)
                    
                    // MARK: - SECTION 2
                    Section {
                        List{
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.isThemeChanged.toggle()
                                }, label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(item.themeColor)
                                        Text(item.themeName)
                                    }
                                }) //: BUTTON
                                .tint(Color.primary)
                            }
                        }
                    } header: {
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding(.vertical, 1)
                    
                    // MARK: - SECTION 3
                    Section{
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimasterclass.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "X", link: "https://twitter.com/robertpetras")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    } header: {
                        Text("Follow us on social media")
                    } //: SECTION 3
                    .padding(.vertical, 1)
                    
                    // MARK: - SECTION 4
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "TODO")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Shakti")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Shakti")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    } //: SECTION 4
                    .padding(.vertical, 1)
                    
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
            } //: VSTACK
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color("ColorBackground")
                    .ignoresSafeArea(.all)
            )
            
        } //: NAVIGATION
        .tint(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
#Preview {
    SettingsView()
        .environmentObject(IconNames())
}
