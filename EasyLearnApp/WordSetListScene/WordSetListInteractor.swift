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
}

final class WordSetListInteractor: WordSetListBusinessLogic {
    
    func deleteWordFromSet(set: String, word: String) {
        let dataHandler = DataHandler()
        dataHandler.deleteWordfromSet(name: set, wordValue: word)
    }
}
