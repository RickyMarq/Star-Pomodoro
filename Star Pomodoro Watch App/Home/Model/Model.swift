//
//  Model.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 14/07/23.
//

import Foundation

struct StarPomodoroPhrases: Codable, Identifiable {
    let id: Int?
    let phrase: String?
    let author: String?
}

struct SavedArrayTags: Codable, Hashable, Identifiable {
    var id = UUID()
    let tagName: String
    var minutesFocused: Int
}
