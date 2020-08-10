//
//  WordSetCardsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetCardConfigurator {
    
    static func assembly(viewController: WordSetCardViewController) {
        
        let presenter = WordSetCardPresenter()
        let interactor = WordSetCardInteractor()
        let router = WordSetCardRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.navigationController = viewController.navigationController
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

