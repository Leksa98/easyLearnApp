//
//  WordSetListConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetListConfigurator {
    static func assembly(viewController: WordListViewController, setTitle: String) {
        let interactor = WordSetListInteractor()
        let presenter = WordSetListPresenter()
        let router = WordSetListRouter()
        viewController.interactor = interactor
        viewController.setName = setTitle
        viewController.router = router
        router.navigationController = viewController.navigationController
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
