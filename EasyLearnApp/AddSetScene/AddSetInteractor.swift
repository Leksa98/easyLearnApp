//
//  AddSetInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AddSetBusinessLogic {
    func saveWordSetInCoreData(name: String, emoji: String, words: [WordModel])
}

final class AddSetInteractor: AddSetBusinessLogic {
    
    var presenter: AddSetPresentationLogic?
    
    func saveWordSetInCoreData(name: String, emoji: String, words: [WordModel]) {
        let dataHandler = DataHandler()
        dataHandler.addWordSetIntoCoreData(name: name, emoji: emoji)
        words.forEach { word in
            dataHandler.addWordtoSet(name: name, word: word.word, translation: word.translation)
        }
        presenter?.prepareForPresent(name: name, emoji: emoji)
    }
}
