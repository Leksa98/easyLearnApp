//
//  WordOfDayConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordOfDayConfigurator {
    
    static func assembly() -> WordOfDayViewController {
        
        let viewController = WordOfDayViewController()
        let presenter = WordOfDayPresenter()
        let interactor = WordOfDayInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = WordOfDayParser()
        presenter.viewController = viewController
        interactor.fetchWordOfDay(request: WordOfDayModel.FetchWordOfDay.Request())
        
        return viewController
    }
}
