//
//  AboutAppConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AboutAppConfigurator {
    
    static func assembly() -> AboutAppViewController {
        
        let viewController = AboutAppViewController()
        let interactor = AboutAppInteractor()
        let presenter = AboutAppPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
