//
//  SummaryService.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 04/10/23.
//

import Foundation

protocol SummaryServiceProtocol: AnyObject {
    func getUserData(userId: String, completion: @escaping (Result<BackResponse, Error>) -> Void)

}

class SummaryService: SummaryServiceProtocol {
    
    
    func getUserData(userId: String, completion: @escaping (Result<BackResponse, Error>) -> Void) {
        
    }
    
}
