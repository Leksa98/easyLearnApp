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
            viewController?.showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel(alertTitleLabel: "Saved!", alertMessageLabel:"Set \(response.name) \(response.emoji) was saved!"))
        } else {
            viewController?.showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel(alertTitleLabel: "Set was saved before!", alertMessageLabel: "Go to your sets to find downloaded set!"))
        }
    }
}
