//
//  NetworkManager.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let router = Router<TranslateWordApi>()
    
    public enum NetworkResponse: String {
        case success
        case authenticationError = "You are not logged in."
        case badRequest = "Bad request"
        case failed = "Request failed"
        case noData = "Request was without data to decode."
        case unableToDecode = "Unable to decode data."
    }
    
    fileprivate func handleNetworkRequest(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 401:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 404:
            return .failure(NetworkResponse.noData.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func translateWord(word: String, completion: @escaping (_ translation: TranslationModel?, _ error: String?) -> ()) {
        router.request(.translate(word: word)) { data, response, error in
            if error != nil {
                completion(nil, "error")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkRequest(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        //let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
                        let apiResponse = try JSONDecoder().decode(TranslationModel.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let NetworkFailureError):
                    completion(nil, NetworkFailureError)
                }
            }
            
        }
    }


}

public enum Result<String> {
    case success
    case failure(String)
}

