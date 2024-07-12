//
//  RegisterService.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 27/09/23.
//

import Foundation
import Alamofire

struct CustomError: Error {
    let message: String
    
    
    init(message: String) {
        self.message = message
    }
}


protocol RegisterServiceProtocol: AnyObject {
    func registerUser(mail: String, password: String, completion: @escaping (Result<BackResponse, Error>) -> Void)
}

class RegisterService: RegisterServiceProtocol {
    
    func registerUser(mail: String, password: String, completion: @escaping (Result<BackResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/user/register") else {return}
        
        let requestData = Login(email: mail, password: password)
        print("Request Data: \(requestData)")
        let encoder = JSONEncoder()
        
        do {
            let requestData = try encoder.encode(requestData)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData
//            print(request.httpMethod)
            AF.request(request).response { response in
                switch response.result {
                case .success(let data):
                    if let httpResponse = response.response, (200..<300).contains(httpResponse.statusCode) {
                        guard let data = data else {return}
                        do {
                            let decoder = JSONDecoder()
                            let data = try decoder.decode(BackResponse.self, from: data)
                            completion(.success(data))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        guard let data = data else {return}
                        do {
                            let decoder = JSONDecoder()
                            let data = try decoder.decode(BackResponse.self, from: data)
                            completion(.failure(CustomError(message: data.message ?? "")))
                        } catch { // Error trying to decode...
                            completion(.failure(error))
                        }
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    }
                }
        } catch {
            print("Error...")
        }
    }
}
