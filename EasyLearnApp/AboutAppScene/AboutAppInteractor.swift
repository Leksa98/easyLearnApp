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
        let description = "This app is designed to help you memorize foreign words. Learn English, German, French, Spanish, and Italian languages. \n\nCreate your own word sets or download default ones. Start learning and track your progress. You can continue learning words even if you are not connected to the Internet. \n\nTake a look at the \"Word of day\" section to expand your vocabulary."
        presenter?.prepareForPresent(response: AboutAppModel.AppDescription.Response(description: description))
    }
}
