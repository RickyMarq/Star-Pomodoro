//
//  SettingsData.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/08/23.
//

import Foundation
import UIKit

class SettingsData {
    
    var dataObjc = [Section]()
    var keepScreenOn = UserDefaults.standard.bool(forKey: "keepScreenOn")
    
    func populateModel() -> [Section] {
        
//        dataObjc.append(Section(title: "Account", cell: [
//            
//            .notificationCell(model: NotificationModel(title: "Notification", icon: UIImage(systemName: "bell.fill") ?? UIImage(), iconBackgroundColor: .systemGray, isOn: false) { doubleHeader in } ),
//                                                            
//        ]))
//        
        
        dataObjc.append(Section(title: "Notifications", cell: [
            
            .notificationCell(model: NotificationModel(tag: 0, title: "Notification", icon: UIImage(systemName: "bell.fill") ?? UIImage(), iconBackgroundColor: .systemRed, isOn: false) { doubleHeader in } ),
                                                            
        ]))
        
        dataObjc.append(Section(title: "Phrases", cell: [
            
            .phraseCell(model: PhraseCellModel(title: "Motivational", isSelected: true)),
            
            .phraseCell(model: PhraseCellModel(title: "Demotivational", isSelected: false))
            
        ]))
                                                            
                                                            
        dataObjc.append(Section(title: "Updates", cell: [
        
            .WhatsNew(model: WhatsNewModelType(title: "What's New", icon: UIImage(systemName: "sparkles.rectangle.stack") ?? UIImage(), iconBackgroundColor: .systemPurple) { doubleHeader in } ),
        
        ]))
        
        dataObjc.append(Section(title: "More", cell: [
            
//            .notificationCell(model: NotificationModel(tag: 1, title: "Keep Screen On", icon: UIImage(systemName: "lasso") ?? UIImage(), iconBackgroundColor: .systemRed, isOn: keepScreenOn) { doubleHeader in self.pog() } ),
            
            .informationCell(model: InformationCellModel(title: "Share Star Pomodoro", icon: UIImage(systemName: "square.and.arrow.up") ?? UIImage(), iconBackgroundColor: .systemIndigo, infoText: "https://apps.apple.com/us/app/star-pomodoro/id6466343741") { doubleHeader in } ),
            
            .documentationCell(model: DocumentationCellModel(title: "Terms & Conditions", icon: UIImage(systemName: "doc") ?? UIImage(), iconBackgroundColor: .systemIndigo, link: "https://doc-hosting.flycricket.io/star-pomodoro-terms-of-use/9b324df7-c08e-4163-a076-07d76fe5d2ab/terms") { doubleHeader in } ),
            
            .documentationCell(model: DocumentationCellModel(title: "Privacy Police", icon: UIImage(systemName: "doc") ?? UIImage(), iconBackgroundColor: .systemIndigo, link: "https://doc-hosting.flycricket.io/star-pomodoro-privacy-policy/9b5bae19-5ea5-4475-88cf-751e2375abe9/privacy") { doubleHeader in } ),
        
        ]))
        
        
        return dataObjc
    }
    
    
    func pog() {
//        keepScreenOn = UserDefaults.standard.bool(forKey: "keepScreenOn")
        keepScreenOn = true
    }
    
}
