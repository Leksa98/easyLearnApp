//
//  WordSetCardsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetCardsConfigurator {
    
    static func assembly() -> WordSetCardsViewController {
        
        let viewController = WordSetCardsViewController()
        let presenter = WordSetCardPresenter()
        let interactor = WordSetCardInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}

