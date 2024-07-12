//
//  AboutScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 08/07/23.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        ScrollView {
            Text("Star Pomodoro")
                .bold()
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Version \(String(String.version))")
                .foregroundColor(Color.accentColor)
                .bold()
            
            Image("image")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding()
            
            Spacer()
            Text("Created by humans 👽")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle("About")
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
