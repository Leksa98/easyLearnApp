//
//  WordSetCardPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetCardPresentationLogic {
    func prepareForPresent(wordsDictionary: [String: String])
}

final class WordSetCardPresenter: WordSetCardPresentationLogic {
    
    weak var viewController: WordSetCardsShow?
    
    func prepareForPresent(wordsDictionary: [String : String]) {
        var wordsArray: [WordModel] = []
        for item in wordsDictionary {
            wordsArray.append(WordModel(word: item.key, translation: item.value))
        }
        viewController?.loadWordSetCards(words: wordsArray)
    }
}
