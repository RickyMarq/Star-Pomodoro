//
//  SettingsViewModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import Foundation

class SettingsViewModel {
    
    var settingsModel = SettingsData().populateModel()
    
    var numberOfSections: Int {
        return settingsModel.count
    }
    
    func rowsInSection(section: Int) -> Int {
        return settingsModel[section].cell.count
    }
    
    func titleForSection(section: Int) -> String {
        return settingsModel[section].title ?? ""
    }
            
    func cellRowBySection(indexPath: IndexPath) -> CellType {
        return settingsModel[indexPath.section].cell[indexPath.row]
    }
    
}
