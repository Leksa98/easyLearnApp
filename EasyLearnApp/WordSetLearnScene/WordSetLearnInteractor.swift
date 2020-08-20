//
//  WordSetLearnInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 03.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetLearnBusinessLogic {
    func fetchWords(request: WordSetLearnModel.FetchWordSet.Request)
    func editWordProgress(request: WordSetLearnModel.EditWordProgress.Request)
}

final class WordSetLearnInteractor: WordSetLearnBusinessLogic {
    var presenter: WordSetLearnResentationLogic?
    
    func fetchWords(request: WordSetLearnModel.FetchWordSet.Request) {
        presenter?.prepareForPresent(response: WordSetLearnModel.FetchWordSet.Response(wordsArray: DataHandler.shared.fetchWords(from: request.setName)))
    }
    
    func editWordProgress(request: WordSetLearnModel.EditWordProgress.Request) {
        DataHandler.shared.updateWordProgress(setName: request.setName, wordUpdate: request.word, progressChange: request.progressChange)
    }
}
