//
//  DefaultWordSetPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetPresentationLogic {
    func prepareForPresent(defaultWordSetModel: DefaultWordSetModel)
}

final class DefaultWordSetPresenter: DefaultWordSetPresentationLogic {
    
    weak var viewController: DefaultWordSetShowLogic?
    
    func prepareForPresent(defaultWordSetModel: DefaultWordSetModel) {
        var wordSet: [WordSetModel] = []
        for set in defaultWordSetModel.defaultSet {
            let newSet = WordSetModel(name: set.name, emoji: set.emoji)
            for word in set.words {
                newSet.addWord(newWord: WordModel(word: word.wordToLearn, translation: word.translation))
            }
            wordSet.append(newSet)
        }
         viewController?.showDefaultSets(sets: wordSet)
    }
}
