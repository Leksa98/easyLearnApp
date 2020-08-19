//
//  WordOfDayPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordOfDayPresentationLogic {
    func prepareForPresent(response: WordOfDayModel.FetchWordOfDay.Response)
}

final class WordOfDayPresenter: WordOfDayPresentationLogic {
    weak var viewController: WordOfDayDisplay?
    
    func prepareForPresent(response: WordOfDayModel.FetchWordOfDay.Response) {
        viewController?.updateContent(viewModel: WordOfDayModel.FetchWordOfDay.ViewModel(wordOfDay: response.wordOfDay))
    }
}
