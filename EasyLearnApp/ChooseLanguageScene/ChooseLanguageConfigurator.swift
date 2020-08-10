//
//  ChooseLanguageConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ChooseLanguageConfigurator {
    
    static func assembly() -> ChooseLanguageViewController {
        
        let viewController = ChooseLanguageViewController()
        let interactor = ChooseLanguageInteractor()
        let presenter = ChooseLanguagePresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
