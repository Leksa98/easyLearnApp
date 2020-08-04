//
//  WordSetLearnPresentor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 03.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetLearnResentationLogic {
    func prepareForPresent(wordSet: [WordModel])
}

final class WordSetLearnPresentor: WordSetLearnResentationLogic {
    weak var viewController: WordSetLearnShow?
    
    func prepareForPresent(wordSet: [WordModel]) {
        let resultArray = wordSet.sorted {
            $0.word < $1.word
        }
        viewController?.showWords(words: resultArray)
    }
}
