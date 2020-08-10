//
//  AddWordPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol PresentTranslations {
    func presentTranslations(response: AddWordModel.WordTranslations.Response)
}

final class AddWordPresenter: PresentTranslations {
    
    weak var viewController: UpdateTranslations?
    
    func presentTranslations(response: AddWordModel.WordTranslations.Response) {
        viewController?.updateTranslations(viewModel: AddWordModel.WordTranslations.ViewModel(translations: response.translations))
    }
}
