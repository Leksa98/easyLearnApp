//
//  AllWordSetsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AllWordSetTableConfigurator {
    
    static func assembly(viewController: AllWordSetTableViewController) {
        
        let presenter = AllWordSetTablePresenter()
        let interactor = AllWordSetTableInteractor()
        let router = AllWordSetTableRouter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.router = router
        router.navigationController = viewController.navigationController
    }
}
