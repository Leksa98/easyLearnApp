//
//  WordSetLearnConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetLearnConfigurator {
    
    static func assembly() -> WordSetLearnViewController {
        
        let viewController = WordSetLearnViewController()
        let presenter = WordSetLearnPresentor()
        let interactor = WordSetLearnInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
