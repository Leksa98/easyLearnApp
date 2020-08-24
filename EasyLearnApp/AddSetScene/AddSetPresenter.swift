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
        if !response.isAlreadyExist {
            viewController?.needToEmptyEnteredInfo = true
            viewController?.showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(alertTitleLabel: "Saved", alertMessageLabel: "Set \(response.name) \(response.emoji) was saved!"))
        } else {
            viewController?.needToEmptyEnteredInfo = false
            viewController?.showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(alertTitleLabel: "Inappropriate name!", alertMessageLabel: "Set with name \(response.name) already exists!"))
        }
    }
}
