//
//  WordSetListPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetListPresentationLogic {
    func prepareForPresent(words: [WordModel])
}

final class WordSetListPresenter: WordSetListPresentationLogic {
    
    weak var viewController: WordListTablePresentationLogic?
    
    func prepareForPresent(words: [WordModel]) {
        viewController?.showWordList(words: words)
    }
}
