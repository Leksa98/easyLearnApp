//
//  DefaultWordSetListInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetListBusinessLogic {
    func downloadWordSet(name: String, emoji: String, words: [WordModel])
}

final class DefaultWordSetListInteractor: DefaultWordSetListBusinessLogic {
    
    var presenter: DefaultWordSetListPresentationLogic?
    
    func downloadWordSet(name: String, emoji: String, words: [WordModel]) {
        let dataHandler = DataHandler()
        dataHandler.addWordSetIntoCoreData(name: name, emoji: emoji)
        for word in words {
            dataHandler.addWordtoSet(name: name, word: word.word, translation: word.translation)
        }
        presenter?.prepareForPresent(name: name, emoji: emoji)
    }
}
