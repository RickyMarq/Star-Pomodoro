//
//  WhatsNewViewModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 30/08/23.
//

import Foundation

class WhatsNewViewModel {
    
    let whatsNewModel = WhatsNewData().populateModel()
    
    var count: Int {
        return whatsNewModel.count
    }
    
    func titleForSection(section: Int) -> String {
        return whatsNewModel[section].title ?? ""
    }
        
    func cellRowBySection(indexPath: IndexPath) -> whatsNewCell {
        return whatsNewModel[indexPath.section].whatsNewCell[indexPath.row]
    }
}
