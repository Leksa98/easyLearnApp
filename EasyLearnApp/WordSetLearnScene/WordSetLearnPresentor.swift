//
//  WordSetLearnPresentor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 03.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetLearnResentationLogic {
    func prepareForPresent(wordSet: [String : String])
}

final class WordSetLearnPresentor: WordSetLearnResentationLogic {
    weak var viewController: WordSetLearnShow?
    
    func prepareForPresent(wordSet: [String : String]) {
        var resultArray: [WordModel] = []
        for item in wordSet {
            resultArray.append(WordModel(word: item.key, translation: item.value))
        }
        viewController?.showWords(words: resultArray)
    }
}
