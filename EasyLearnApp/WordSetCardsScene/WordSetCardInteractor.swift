//
//  WordSetCardInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetCardBusinessLogic {
    func fetchWordSet(request: WordSetCardModel.FetchWordSet.Request)
}

final class WordSetCardInteractor: WordSetCardBusinessLogic {
    
    var presenter: WordSetCardPresentationLogic?
    var worker: DataStorageWordSetView?
    
    func fetchWordSet(request: WordSetCardModel.FetchWordSet.Request) {
        if let words =  worker?.fetchWords(from: request.setName) {
            presenter?.prepareForPresent(response: WordSetCardModel.FetchWordSet.Response(wordsArray: words))
        }
    }
}
