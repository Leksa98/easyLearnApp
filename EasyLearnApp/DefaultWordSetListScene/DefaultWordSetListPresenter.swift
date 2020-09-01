//
//  DefaultWordSetListPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetListPresentationLogic {
    func prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response?)
}

final class DefaultWordSetListPresenter: DefaultWordSetListPresentationLogic {
    
    weak var viewController: DefaultWordSetListSaveNotification?
    
    func prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response?) {
        if let response = response {
            viewController?.showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel(alertTitleLabel: NSLocalizedString("alert_success_title", comment: ""), alertMessageLabel:"\(response.name) \(response.emoji) " + NSLocalizedString("alert_success_message", comment: "")))
        } else {
            viewController?.showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel(alertTitleLabel: NSLocalizedString("default_word_set_alert_fail_title", comment: ""), alertMessageLabel: NSLocalizedString("default_word_set_alert_fail_message", comment: "")))
        }
    }
}
