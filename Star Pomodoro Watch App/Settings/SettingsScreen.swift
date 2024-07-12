//
//  SettingsScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 08/07/23.
//

import SwiftUI

struct SettingsModel: Identifiable {
    let id: Int
    let name: String
    let icon: String
    let destinationView: AnyView
}

struct SettingsScreen: View {
    
    var data = [SettingsModel(id: 0, name: "Notifications", icon: "bell", destinationView: AnyView(NotificationScreen())), SettingsModel(id: 1, name: "About", icon: "person", destinationView: AnyView(AboutScreen())), SettingsModel(id: 2, name: "Sounds", icon: "speaker.wave.3", destinationView: AnyView(AudioScreen())), SettingsModel(id: 3, name: "Phrases", icon: "person.wave.2.fill", destinationView: AnyView(PhrasesScreen()))]
    
    var body: some View {
        if #available(watchOS 8.0, *) {
            NavigationView {
                List {
                    ForEach(data, id: \.id) { datum in
                        NavigationLink(destination: datum.destinationView) {
                            HStack {
                                Image(systemName: datum.icon)
                                    .foregroundColor(Color.accentColor)
                                    .padding()
                                
                                Text(datum.name)
                                    .bold()
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Configs")
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
