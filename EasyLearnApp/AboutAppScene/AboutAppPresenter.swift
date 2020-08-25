//
//  AboutAppPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AboutAppPresentationLogic {
    func prepareForPresent(response: AboutAppModel.AppDescription.Response)
}

final class AboutAppPresenter: AboutAppPresentationLogic {
    weak var viewController: AboutAppDisplayLogic?
    
    func prepareForPresent(response: AboutAppModel.AppDescription.Response) {
        viewController?.updateDescription(viewModel: AboutAppModel.AppDescription.ViewModel(description: response.description))
    }
}
