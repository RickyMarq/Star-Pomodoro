//
//  AudioController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 28/08/23.
//

import Foundation
import AVFoundation

class AudioController {
     
    static let sharedObjc = AudioController()
    var soundEffect: AVAudioPlayer?
    
    private init() {}
    
    func playSelectedAudio(audio: String) {
        guard let path = Bundle.main.path(forResource: audio, ofType:nil) else {return}
        let url = URL(fileURLWithPath: path)
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.prepareToPlay()
            soundEffect?.play()
        } catch {
            print("Failed to play audio \(error.localizedDescription)")
        }
    }
}
