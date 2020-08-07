//
//  WordSetListConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetListConfigurator {
    static func assembly(viewController: WordListTableViewController) {
        let interactor = WordSetListInteractor()
        let presenter = WordSetListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
