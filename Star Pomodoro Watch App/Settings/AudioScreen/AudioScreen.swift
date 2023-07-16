//
//  AudioScreen.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 10/07/23.
//

import SwiftUI
import AVFoundation

struct AudioModel: Identifiable {
    let id: Int
    let audioName: String
    let audioNamePlay: String
    var isSelected: Bool
}

struct AudioScreen: View {
    
    @State var data = [AudioModel(id: 0, audioName: "Sparkles", audioNamePlay: "sound-effect-twinklesparkle-115095.wav", isSelected: false), AudioModel(id: 1, audioName: "Forest", audioNamePlay: "Forest.mp3", isSelected: false)]
   
    @State var isSelectedString: String = (UserDefaults.standard.string(forKey: "AudioSelected") ?? "")
    
    var body: some View {
        List {
            ForEach(data, id: \.id) { datum in
                HStack {
                    Text(datum.audioName)
                    
                    if isSelectedString == datum.audioNamePlay {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.accentColor)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    }
                    
                    
                }
                .onTapGesture {
                    AudioController.sharedObjc.playSelectedAudio(audio: datum.audioNamePlay)
                    print(datum.audioNamePlay)
                    isSelectedString = datum.audioNamePlay
                    UserDefaults.standard.set(isSelectedString, forKey: "AudioSelected")
                }
            }
        }
        .navigationBarTitle("Sounds")
        
        .onAppear {
     //       UserDefaults.standard.value(forKey: "AudioSelected")
            isSelectedString = UserDefaults.standard.string(forKey: "AudioSelected") ?? "sound-effect-twinklesparkle-115095.wav"
        }
    }
}

struct AudioScreen_Previews: PreviewProvider {
    static var previews: some View {
        AudioScreen()
    }
}
