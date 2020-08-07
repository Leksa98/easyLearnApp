//
//  AddWordConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddWordConfigurator {
    
    static func assembly() -> AddWordViewController {
        
        let viewController = AddWordViewController()
        let presenter = AddWordPresenter()
        let interactor = AddWordInteractor()
        let router = AddWordRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }

}
