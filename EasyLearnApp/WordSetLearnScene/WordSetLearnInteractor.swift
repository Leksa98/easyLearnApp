//
//  WordSetLearnInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 03.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetLearnBusinessLogic {
    func fetchWords(setName: String)
    func editWordProgress(word: String, progressChange: Double)
}

final class WordSetLearnInteractor: WordSetLearnBusinessLogic {
    var presenter: WordSetLearnResentationLogic?
    
    func fetchWords(setName: String) {
        let dataHandler = DataHandler()
        presenter?.prepareForPresent(wordSet: dataHandler.fetchWords(from: setName))
    }
    
    func editWordProgress(word: String, progressChange: Double) {
        let dataHandler = DataHandler()
        dataHandler.updateWordProgress(word: word, progressChange: progressChange)
    }
}
