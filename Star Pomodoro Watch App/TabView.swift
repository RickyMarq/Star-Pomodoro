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
    }
}

struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
