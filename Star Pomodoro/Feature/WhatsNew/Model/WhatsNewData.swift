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
        
        model.append(WhatsNewSection(title: "February 1, 2024", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.4", infoText: "• Adding suport for VisionOS", updateLabel: "Releases Notes", actualVersion: true))
        ]))
        
        model.append(WhatsNewSection(title: "September 26, 2023", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.3", infoText: "• Now introducing tags, you can can create your own tags to help you focus. \n \n • Fixed a bug that didn't let users share Star Pomodoro.", updateLabel: "Releases Notes", actualVersion: false))
        ]))
        
        model.append(WhatsNewSection(title: "September 24, 2023", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.2", infoText: "• Fixed a bug that prevent user to select 'demotivational' phrases. \n \n • Bring back the option to user select a 5 minutes timer, my bad.", updateLabel: "Bug Fixes", actualVersion: false))
        ]))
        
        
        model.append(WhatsNewSection(title: "September 20, 2023", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.1", infoText: "• Star Pomodoro now have support for Live Activities", updateLabel: "Release Notes", actualVersion: false))
        ]))
        
        model.append(WhatsNewSection(title: "September 14, 2023", whatsNewCell: [
            .whatsNewCell(model: WhatsNewCellModel(version: "1.0.0", infoText: "• Star Pomodoro it's now available on the App Store", updateLabel: "Release Notes", actualVersion: false))
        ]))
        
        return model
    }
    
}
