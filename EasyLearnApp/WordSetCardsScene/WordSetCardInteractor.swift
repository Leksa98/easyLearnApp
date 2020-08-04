//
//  WordSetCardInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetCardBusinessLogic {
    func fetchWordSet(setName: String)
}

final class WordSetCardInteractor: WordSetCardBusinessLogic {
    
    var presenter: WordSetCardPresentationLogic?
    
    func fetchWordSet(setName: String) {
        let dataHandler = DataHandler()
        presenter?.prepareForPresent(wordsArray: dataHandler.fetchWords(from: setName))
    }
}
