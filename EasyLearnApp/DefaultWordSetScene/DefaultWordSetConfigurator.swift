//
//  DefaultWordSetConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class DefaultWordSetConfigurator {
    
    static func assembly(viewController: DefaultWordSetViewController) {
        
        let presenter = DefaultWordSetPresenter()
        let interactor = DefaultWordSetInteractor()
        let router = DefaultWordSetRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.navigationController = viewController.navigationController
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
