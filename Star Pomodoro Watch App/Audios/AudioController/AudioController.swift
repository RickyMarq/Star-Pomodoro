//
//  AudioController.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 10/07/23.
//

import Foundation
import AVFoundation

class AudioController {
     
    static let sharedObjc = AudioController()
    var soundEffect: AVAudioPlayer?
    
    private init() {}
    
    func playTaskComplete() {
        guard let path = Bundle.main.path(forResource: "sound-effect-twinklesparkle-115095.wav", ofType:nil) else {return}
        let url = URL(fileURLWithPath: path)
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.prepareToPlay()
            soundEffect?.play()
        } catch {
            print("Failed to play audio \(error.localizedDescription)")
        }
    }
    
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
