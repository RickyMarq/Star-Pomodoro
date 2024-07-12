//
//  HomeScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 08/07/23.
//

import SwiftUI

struct HomeInterfaceModel: Identifiable {
    let id: Int?
    let name: String
    let icon: String
    let destinationView: AnyView
    let imageContainer: [ImageContainer]
}

struct ImageContainer: Identifiable {
    let id: Int?
    let image: String?
}

struct HomeScreen: View {
    
    @State public static var shiningStarsCount = 0
    @State var data = [HomeInterfaceModel(id: 0, name: "Pomodoro", icon: "timer", destinationView: AnyView(FastPomodoro()), imageContainer: []), HomeInterfaceModel(id: 1, name: "Config", icon: "gear", destinationView: AnyView(SettingsScreen()), imageContainer: []), HomeInterfaceModel(id: 2, name: "Overall", icon: "list.bullet", destinationView: AnyView(OverallScreen()), imageContainer: [])]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data, id: \.id) { datum in
                    NavigationLink(destination: datum.destinationView) {
                        if datum.imageContainer.isEmpty == false {
                            VStack {
                                Image("Overall")
                                    .resizable()
                                    .scaledToFill()
                                
                                Text("You have \(String(HomeScreen.shiningStarsCount)) shining stars")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            HStack {
                                Image(systemName: datum.icon)
                                    .foregroundColor(Color.accentColor)
                                Text(datum.name)
                                    .bold()
                            }
                        }
                    }
                }
                .navigationTitle("Stars")
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
