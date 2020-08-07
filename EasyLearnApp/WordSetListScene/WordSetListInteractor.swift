//
//  WordSetListInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 28.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetListBusinessLogic {
    func deleteWordFromSet(set: String, word: String)
    func addWordToSet(setName: String, word: WordModel)
    func fetchWordSet(setName: String)
}

final class WordSetListInteractor: WordSetListBusinessLogic {
    
    var presenter: WordSetListPresentationLogic?
    
    func deleteWordFromSet(set: String, word: String) {
        let dataHandler = DataHandler()
        dataHandler.deleteWordfromSet(name: set, wordValue: word)
    }
    
    func addWordToSet(setName: String, word: WordModel) {
        let dataHandler = DataHandler()
        dataHandler.addWordtoSet(name: setName, word: word.word, translation: word.translation)
    }
    
    func fetchWordSet(setName: String) {
        let dataHandler = DataHandler()
        presenter?.prepareForPresent(words: dataHandler.fetchWords(from: setName))
    }
}
