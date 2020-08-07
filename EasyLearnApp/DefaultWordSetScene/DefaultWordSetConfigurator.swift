//
//  DefaultWordSetConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class DefaultWordSetConfigurator {
    
    static func assembly() -> DefaultWordSetViewController {
        
        let viewController = DefaultWordSetViewController()
        let presenter = DefaultWordSetPresenter()
        let interactor = DefaultWordSetInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
