//
//  AllWordSetsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AllWordSetsConfigurator {
    
    static func assembly() -> UIViewController {
        
        let viewController = WordSetTableViewController()
        let presenter = WordSetTablePresenter()
        let interactor = WordSetTableInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
