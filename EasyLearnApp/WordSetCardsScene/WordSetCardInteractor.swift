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
    
    func fetchWordSet(request: WordSetCardModel.FetchWordSet.Request) {
        presenter?.prepareForPresent(response: WordSetCardModel.FetchWordSet.Response(wordsArray: DataHandler.shared.fetchWords(from: request.setName)))
    }
}
