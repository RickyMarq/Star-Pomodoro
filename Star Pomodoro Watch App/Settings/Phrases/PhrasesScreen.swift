//
//  PhrasesScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 10/07/23.
//

import SwiftUI

struct PhrasesScreen: View {
    
    var data = PhrasesModelToPopulate().populateModel()
    @State var isPersonalitySelected: String?
    @State var previewPhrase: String?
    
    var body: some View {
        List {
            Section {
                ForEach(data) { datum in
                    HStack {
                        Text(datum.personalityName)
                        
                        if isPersonalitySelected == datum.personalityName {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.accentColor)
                                .frame(alignment: .trailing)
                        }
                    }
                    .onTapGesture {
                        UserDefaults.standard.set(datum.personalityName, forKey: "PersonalitySelected")
                        isPersonalitySelected = datum.personalityName
                        previewPhrase = datum.phases[0].phrase
                    }
                }
            } header: {
                Text("You can set a custom personality for your phrases when you're trying to focus")
                    .textCase(nil)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            } footer: {
                Text("Preview: " + (previewPhrase ?? "You can do this."))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
//                    .lineLimit(0)
            }

            
        }
        .listStyle(.plain)
        .onAppear(perform: {
            
            // Remember saving this default value another time
            
            isPersonalitySelected = UserDefaults.standard.string(forKey: "PersonalitySelected")
            
        })
        
        .navigationTitle("Phrases")
    }
}

struct PhrasesScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesScreen()
    }
}
