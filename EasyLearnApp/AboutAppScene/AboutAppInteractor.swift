//
//  AboutAppInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AboutAppBusinessLogic {
    func fetchDescription(request: AboutAppModel.AppDescription.Request)
}

final class AboutAppInteractor: AboutAppBusinessLogic {
    var presenter: AboutAppPresentationLogic?
    
    func fetchDescription(request: AboutAppModel.AppDescription.Request) {
        let description = NSLocalizedString("app_description", comment: "")
        presenter?.prepareForPresent(response: AboutAppModel.AppDescription.Response(description: description))
    }
}
