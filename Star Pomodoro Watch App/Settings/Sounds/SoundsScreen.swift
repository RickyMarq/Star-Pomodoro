//
//  SoundsScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 08/07/23.
//

import SwiftUI

struct SoundsModel: Identifiable {
    let id: Int
    let name: String
    let sound: String
}

struct SoundsScreen: View {
    var body: some View {
        List {
            Text("AA")
            
            Text("BB")

            Text("CC")
        }
//        .listStyle(.carousel)
        .navigationTitle("Sounds")
    }
}

struct SoundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SoundsScreen()
    }
}
