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
}

final class WordSetListInteractor: WordSetListBusinessLogic {
    
    func deleteWordFromSet(set: String, word: String) {
        let dataHandler = DataHandler()
        dataHandler.deleteWordfromSet(name: set, wordValue: word)
    }
    
    func addWordToSet(setName: String, word: WordModel) {
        let dataHandler = DataHandler()
        dataHandler.addWordtoSet(name: setName, word: word.word, translation: word.translation)
    }
}
