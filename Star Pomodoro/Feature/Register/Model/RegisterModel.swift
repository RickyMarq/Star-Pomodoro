//
//  RegisterModel.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//

import Foundation

struct Login: Codable {
    let email: String?
    let password: String?
}

struct BackResponse: Codable {
    let message: String?
    let userID: String?
}
