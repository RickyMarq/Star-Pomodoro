//
//  OnboardingViewModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import Foundation

class OnboardingViewModel {
    
    var objc: [OnboardingDataModel] = []
    
    func populateObjc() {
        
        objc.append(contentsOf: [
            
            OnboardingDataModel(name: "Welcome to Star Pomodoro", image: "ZTGMCo71eD (1).json", description: "A minimalistic way to stay focused"),
            
            OnboardingDataModel(name: "Can we send notifications?", image: "BellAnimation.json", description: "We use it to alert you when it's time to rest."),
            
            OnboardingDataModel(name: "So let's get focused?", image: "StudyingAnimation.json", description: "Hit begin button to start")
            
        ])
        
    }
    
    var count: Int {
        return objc.count
    }
    
    func indexPath(indexPath: IndexPath) -> OnboardingDataModel {
        self.objc[indexPath.row]
    }
}
