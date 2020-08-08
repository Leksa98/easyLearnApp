//
//  WordSetListPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetListPresentationLogic {
    func prepareForPresent(response: WordSetListModel.FetchWordSet.Response)
}

final class WordSetListPresenter: WordSetListPresentationLogic {
    
    weak var viewController: WordListTablePresentationLogic?
    
    func prepareForPresent(response: WordSetListModel.FetchWordSet.Response) {
        viewController?.showWordList(viewModel: WordSetListModel.FetchWordSet.ViewModel(words: response.words))
    }
}
