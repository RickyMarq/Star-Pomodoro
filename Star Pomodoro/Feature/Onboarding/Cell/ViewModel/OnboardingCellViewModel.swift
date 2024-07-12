//
//  OnboardingCellViewModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import Foundation

class OnboardingCellViewModel {
    
    var objc: OnboardingDataModel?
    
    init(objc: OnboardingDataModel? = nil) {
        self.objc = objc
    }
    
    var primaryLabel: String {
        return objc?.name ?? ""
    }
    
    var secondaryLabel: String {
        return objc?.description ?? ""
    }
    
    var imageString: String {
        return objc?.image ?? ""
    }
}
