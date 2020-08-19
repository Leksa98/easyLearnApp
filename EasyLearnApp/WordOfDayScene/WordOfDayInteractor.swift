//
//  WordOfDayInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordOfDayBusinessLogic {
    func fetchWordOfDay()
}

final class WordOfDayInteractor: WordOfDayBusinessLogic {
    var presenter: WordOfDayPresentationLogic?
    
    func fetchWordOfDay() {
        let networkManager = NetworkManager()
        networkManager.fetchWordOfDay { apiResponse, error in
            if let error = error {
                print(error)
            }
            if let apiResponse = apiResponse {
                print(apiResponse)
            }
        }
    }
}
