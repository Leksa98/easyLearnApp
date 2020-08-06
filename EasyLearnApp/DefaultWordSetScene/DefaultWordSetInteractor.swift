//
//  DefaultWordSetInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetBusinessLogic {
    func fetchDefaultSet()
}

final class DefaultWordSetInteractor: DefaultWordSetBusinessLogic {
    
    var presenter: DefaultWordSetPresentationLogic?
    
    func fetchDefaultSet() {
        let networkManager = NetworkManager()
        networkManager.fetchDefaultWordSets { apiResponse, error in
            if let error = error {
                print(error)
            }
            if let apiResponse = apiResponse {
                self.presenter?.prepareForPresent(defaultWordSetModel: apiResponse)
            }
        }
    }
}
