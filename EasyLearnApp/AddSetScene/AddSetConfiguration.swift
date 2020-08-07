//
//  AddSetConfiguration.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetConfiguration {
    
    static func assembly(viewController: AddSetViewController) {
        
        let presenter = AddSetPresenter()
        let interactor = AddSetInteractor()
        let router = AddSetRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.navigationController = viewController.navigationController
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

