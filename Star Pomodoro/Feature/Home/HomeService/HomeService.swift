//
//  HomeService.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 26/08/23.
//

import Foundation

class HomeService {
    
    static let sharedObjc = HomeService()
    
    private init() {}
    
    enum Errors: String, Error {
        case badUrl = ""
    }
    
    func getMotivotionalPhrase(completion: @escaping (Result<StarPomodoroPhrases?, Errors>) -> Void) {
        guard let url = URL(string: "https://star-pomodoro-api.vercel.app/getmotivotionalrandomphrase") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(StarPomodoroPhrases.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
    
    
    func getunmotivadedPhrase(completion: @escaping (Result<StarPomodoroPhrases?, Errors>) -> Void) {
        guard let url = URL(string: "https://star-pomodoro-api.vercel.app/getunmotivotionalrandomphrase") else {return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Errors.badUrl))
                return}
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(StarPomodoroPhrases.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(Errors.badUrl))
            }
        }
        .resume()
    }
}
