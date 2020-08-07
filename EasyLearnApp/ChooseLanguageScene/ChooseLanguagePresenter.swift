//
//  ChooseLanguagePresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol ChooseLanguagePresentationLogic {
    func prepareForPresent(languages: [ChooseLanguageModel])
}

final class ChooseLanguagePresenter: ChooseLanguagePresentationLogic {
    
    weak var viewController: ChooseLanguageShowTableView?
    
    func prepareForPresent(languages: [ChooseLanguageModel]) {
        viewController?.loadDataInTableView(languages: languages)
    }
}
