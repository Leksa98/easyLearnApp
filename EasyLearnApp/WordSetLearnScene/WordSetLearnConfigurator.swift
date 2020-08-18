//
//  WordSetLearnConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetLearnConfigurator {
    
    static func assembly(viewController: WordSetLearnViewController) {
        
        let presenter = WordSetLearnPresentor()
        let interactor = WordSetLearnInteractor()
        let router = WordSetLearnRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.navigationController = viewController.navigationController
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
