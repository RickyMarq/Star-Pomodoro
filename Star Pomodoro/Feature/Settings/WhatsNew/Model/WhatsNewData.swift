//
//  WhatsNewData.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 30/08/23.
//

import Foundation

class WhatsNewData {
    
    var model = [WhatsNewSection]()
    
    func populateModel() -> [WhatsNewSection] {
        
        model.append(WhatsNewSection(title: "July 31, 2023", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.0", infoText: "• Star Pomodoro it's now available on the App Store", updateLabel: "Release Notes", actualVersion: true))
        ]))
        
        return model
    }
    
}
