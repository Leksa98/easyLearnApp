//
//  WordSetListInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 28.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetListBusinessLogic {
    func deleteWordFromSet(request: WordSetListModel.DeleteWordFromSet.Request)
    func addWordToSet(request: WordSetListModel.AddWordToSet.Request)
    func fetchWordSet(request: WordSetListModel.FetchWordSet.Request)
}

final class WordSetListInteractor: WordSetListBusinessLogic {
    
    var presenter: WordSetListPresentationLogic?
    
    func deleteWordFromSet(request: WordSetListModel.DeleteWordFromSet.Request) {
        let dataHandler = DataHandler()
        dataHandler.deleteWordfromSet(name: request.set, wordValue: request.word)
    }
    
    func addWordToSet(request: WordSetListModel.AddWordToSet.Request) {
        let dataHandler = DataHandler()
        dataHandler.addWordtoSet(name: request.setName, word: request.word.word, translation: request.word.translation)
    }
    
    func fetchWordSet(request: WordSetListModel.FetchWordSet.Request) {
        let dataHandler = DataHandler()
        presenter?.prepareForPresent(response: WordSetListModel.FetchWordSet.Response(words: dataHandler.fetchWords(from: request.setName)))
    }
}
