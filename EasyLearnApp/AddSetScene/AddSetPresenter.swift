//
//  AddSetPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AddSetPresentationLogic {
    func prepareForPresent(response: AddSetModel.SaveWordSet.Response)
}

final class AddSetPresenter: AddSetPresentationLogic {
    
    weak var viewController: AddSetSavedNotification?
    
    func prepareForPresent(response: AddSetModel.SaveWordSet.Response) {
        viewController?.showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(name: response.name, emoji: response.emoji))
    }
}
