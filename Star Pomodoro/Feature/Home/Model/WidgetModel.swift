//
//  WidgetModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 15/09/23.
//

import Foundation
import SwiftUI
import ActivityKit

struct PomodoroAttributes: ActivityAttributes {
    
    struct ContentState: Codable, Hashable {
        
    }
    
    var phrase: String
    var minutesLeft: Double
    var tagSelected: String
    
}
