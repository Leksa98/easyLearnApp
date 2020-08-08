//
//  DefaultWordSetListPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetListPresentationLogic {
    func prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response)
}

final class DefaultWordSetListPresenter: DefaultWordSetListPresentationLogic {
    
    weak var viewController: DefaultWordSetListSaveNotification?
    
    func prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response) {
        viewController?.showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel(name: response.name, emoji: response.emoji))
    }
}
