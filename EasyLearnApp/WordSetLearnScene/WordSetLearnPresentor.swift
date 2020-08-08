//
//  WordSetLearnPresentor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 03.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetLearnResentationLogic {
    func prepareForPresent(response: WordSetLearnModel.FetchWordSet.Response)
}

final class WordSetLearnPresentor: WordSetLearnResentationLogic {
    weak var viewController: WordSetLearnShow?
    
    func prepareForPresent(response: WordSetLearnModel.FetchWordSet.Response) {
        var resultArray = response.wordsArray.filter { $0.progress < 1.0 }
        if resultArray.isEmpty {
            resultArray = response.wordsArray
        }
        response.wordsArray.forEach { word in
            resultArray.append(WordModel(word: word.translation, translation: word.word, progress: word.progress))
        }
        response.wordsArray.forEach { word in
            if word.progress < 0.5 {
                resultArray.append(word)
                resultArray.append(WordModel(word: word.translation, translation: word.word, progress: word.progress))
            }
        }
        resultArray.shuffle()
        viewController?.showWords(viewModel: WordSetLearnModel.FetchWordSet.ViewModel(wordsArray: resultArray))
    }
}
