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
            viewController?.showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(alertTitleLabel: NSLocalizedString("alert_success_title", comment: ""), alertMessageLabel: "\(response.name) \(response.emoji) " + NSLocalizedString("alert_success_message", comment: "")))
        } else {
            viewController?.needToEmptyEnteredInfo = false
            viewController?.showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(alertTitleLabel: NSLocalizedString("add_set_alert_fail_title", comment: ""), alertMessageLabel: NSLocalizedString("add_set_alert_fail_message_start", comment: "") + " \(response.name) " + NSLocalizedString("add_set_alert_fail_message_end", comment: "")))
        }
    }
}
