//
//  WordSetStatisticsConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetStatisticsConfigurator {
    
    static func assembly() -> WordSetStatisticsViewController {
        
        let viewController = WordSetStatisticsViewController()
        let presenter = WordSetStatisticsPresentor()
        let interactor = WordSetStatisticsInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
