//
//  Notifications.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 07/07/23.
//

import Foundation
import UserNotifications

class NotificationController {
    
    static let sharedObjc = NotificationController()
    
    private init() {}
    
    func getNotification(title: String, body: String, timeInterval: Double, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let identifier = identifier
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
