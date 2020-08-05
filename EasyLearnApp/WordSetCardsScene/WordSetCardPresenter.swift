//
//  WordSetCardPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetCardPresentationLogic {
    func prepareForPresent(wordsArray: [WordModel])
}

final class WordSetCardPresenter: WordSetCardPresentationLogic {
    
    weak var viewController: WordSetCardsShow?
    
    func prepareForPresent(wordsArray: [WordModel]) {
        viewController?.loadWordSetCards(words: wordsArray)
    }
}
