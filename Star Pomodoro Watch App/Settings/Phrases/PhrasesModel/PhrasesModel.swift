//
//  PhrasesModel.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 10/07/23.
//

import Foundation

struct PhrasesModel: Identifiable {
    let id: Int
    let personalityName: String
    let phases: [Phrases]
    let pomodoroPhases: [Phrases]
}

struct Phrases: Identifiable {
    let id: Int
    let phrase: String
}

class PhrasesModelToPopulate {
    
    var model: [PhrasesModel] = []
    
    func populateModel() -> [PhrasesModel] {
        
        model = [
            PhrasesModel(id: 0, personalityName: "Motivational",
                         phases: [Phrases(id: 0, phrase: "We can do this, let's go"),
                                  Phrases(id: 1, phrase: "Let's go")],
                         pomodoroPhases: [Phrases(id: 0, phrase: "Let's do this.")]),
            
            
            PhrasesModel(id: 1, personalityName: "Unmotivated", phases: [Phrases(id: 0, phrase: "If you don't try technically you will not fail, lol")], pomodoroPhases: [Phrases(id: 0, phrase: "Geez, you can even get focused for a short period of time?")])
        ]
        
        
        return model
    }
    
    
}
