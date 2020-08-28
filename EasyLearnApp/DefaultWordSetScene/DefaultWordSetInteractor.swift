//
//  DefaultWordSetInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetBusinessLogic {
    func fetchDefaultSet(request: DefaultWordSetModel.FetchDefaultSets.Request)
}

final class DefaultWordSetInteractor: DefaultWordSetBusinessLogic {
    
    var presenter: DefaultWordSetPresentationLogic?
    var worker: DefaultWordSetsNetworkRequest?
    
    func fetchDefaultSet(request: DefaultWordSetModel.FetchDefaultSets.Request) {
        worker?.fetchDefaultWordSets { apiResponse, error in
            if let error = error {
                print(error)
            }
            if let apiResponse = apiResponse {
                self.presenter?.prepareForPresent(response: DefaultWordSetModel.FetchDefaultSets.Response(defaultWordSetModel: apiResponse))
            }
        }
    }
}
