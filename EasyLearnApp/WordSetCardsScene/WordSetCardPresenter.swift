//
//  WordSetCardPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetCardPresentationLogic {
    func prepareForPresent(response: WordSetCardModel.FetchWordSet.Response)
}

final class WordSetCardPresenter: WordSetCardPresentationLogic {
    
    weak var viewController: WordSetCardsShow?
    
    func prepareForPresent(response: WordSetCardModel.FetchWordSet.Response) {
        viewController?.loadWordSetCards(viewModel: WordSetCardModel.FetchWordSet.ViewModel(wordsArray: response.wordsArray))
    }
}
