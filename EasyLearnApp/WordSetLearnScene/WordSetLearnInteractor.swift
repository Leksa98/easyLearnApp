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
    
    var presenter: WordSetLearnPresentationLogic?
    var worker: (DataStorageWordSetView & DataStorageWordSetProgress)?
    
    func fetchWords(request: WordSetLearnModel.FetchWordSet.Request) {
        if let words = worker?.fetchWords(from: request.setName) {
            presenter?.prepareForPresent(response: WordSetLearnModel.FetchWordSet.Response(wordsArray: words))
        }
    }
    
    func editWordProgress(request: WordSetLearnModel.EditWordProgress.Request) {
        worker?.updateWordProgress(setName: request.setName, wordUpdate: request.word, progressChange: request.progressChange)
    }
}
