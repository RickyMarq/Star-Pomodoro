//
//  TabView.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 13/07/23.
//

import SwiftUI

struct TabViewApp: View {
    var body: some View {
        TabView {
            FastPomodoro()
            OverallScreen()
            SettingsScreen()
        }
        .tabViewStyle(PageTabViewStyle())
        
        .onAppear {
            if UserDefaults.standard.bool(forKey: "notFirstInApp") == false {
                UserDefaults.standard.setValue(true, forKey: "notFirstInApp")
                UserDefaults.standard.set("Motivational", forKey: "PersonalitySelected")

                
                let arrayToSave = [SavedArrayTags(tagName: "Work", minutesFocused: 0),
                                   SavedArrayTags(tagName: "Study", minutesFocused: 0),
                                   SavedArrayTags(tagName: "Other", minutesFocused: 0)]
                
                do {
                    let encoded = try JSONEncoder().encode(arrayToSave)
                    UserDefaults.standard.setValue(encoded, forKey: "FocusedData")
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                
            }
        }
    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
