//
//  WordOfDayInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordOfDayBusinessLogic {
    func fetchWordOfDay(request: WordOfDayModel.FetchWordOfDay.Request)
}

final class WordOfDayInteractor: WordOfDayBusinessLogic {
    
    var presenter: WordOfDayPresentationLogic?
    var worker: WordOfDayParse?
    
    func fetchWordOfDay(request: WordOfDayModel.FetchWordOfDay.Request) {
        worker?.fetchWordOfDay { apiResponse, error in
            if let error = error {
                print(error)
            }
            if let apiResponse = apiResponse {
                self.presenter?.prepareForPresent(response: WordOfDayModel.FetchWordOfDay.Response(wordOfDay: apiResponse))
            }
        }
    }
}
