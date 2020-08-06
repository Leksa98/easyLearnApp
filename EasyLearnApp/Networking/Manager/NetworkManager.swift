//
//  NetworkManager.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

public enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager {
    private let translationRouter = Router<TranslateWordApi>()
    private let defaultSetsRouter = Router<DefaultWordSetModelApi>()
    
    public enum NetworkResponse: String {
        case success
        case invalidKey = "Invalid API key"
        case blockedKey = "This API key has been blocked"
        case exceededDailyLimit = "Exceeded the daily limit on the number of requests"
        case textSizeExceeded = "The text size exceeds the maximum"
        case lansuageNotSupported = "The specified translation direction is not supported"
        case failed = "Request failed"
        case noData = "Response returned with no data to decode."
        case unableToDecode = "Unable to decode data."
    }
    
    fileprivate func handleNetworkRequest(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200:
            return .success
        case 401:
            return .failure(NetworkResponse.invalidKey.rawValue)
        case 402:
            return .failure(NetworkResponse.blockedKey.rawValue)
        case 403:
            return .failure(NetworkResponse.exceededDailyLimit.rawValue)
        case 413:
            return .failure(NetworkResponse.textSizeExceeded.rawValue)
        case 501:
            return .failure(NetworkResponse.lansuageNotSupported.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    
    func translateWord(word: String, completion: @escaping (_ translation: TranslationModel?, _ error: String?) -> ()) {
        translationRouter.request(.translate(word: word)) { data, response, error in
            if error != nil {
                completion(nil, "Error")
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
    
    func fetchDefaultWordSets(completion: @escaping (_ translation: DefaultWordSetModel?, _ error: String?) -> ()) {
        defaultSetsRouter.request(.fetchDefaultWordSet) { data, response, error in
            if error != nil {
                completion(nil, "Error")
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
                        let apiResponse = try JSONDecoder().decode(DefaultWordSetModel.self, from: responseData)
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
