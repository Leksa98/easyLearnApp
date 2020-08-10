//
//  ChooseLanguagePresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol ChooseLanguagePresentationLogic {
    func prepareForPresent(response: ChooseLanguageModel.Language.Response)
}

final class ChooseLanguagePresenter: ChooseLanguagePresentationLogic {
    
    weak var viewController: ChooseLanguageShowTableView?
    
    func prepareForPresent(response: ChooseLanguageModel.Language.Response) {
        viewController?.loadDataInTableView(viewModel: ChooseLanguageModel.Language.ViewModel(languages: response.languages))
    }
}
