//
//  WordSetCardsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetCardConfigurator {
    
    static func assembly() -> WordSetCardViewController {
        
        let viewController = WordSetCardViewController()
        let presenter = WordSetCardPresenter()
        let interactor = WordSetCardInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}

