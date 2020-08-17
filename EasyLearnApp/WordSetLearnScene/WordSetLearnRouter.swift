//
//  WordSetLearnRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 10.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetLearnRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeBack()
    func routeFinishedExerciseScene(with title: String)
}

final class WordSetLearnRouter: WordSetLearnRouterLogic {
    
    weak var navigationController: UINavigationController?
    
    func routeBack() {
        navigationController?.popViewController(animated: false)
    }
    
    func routeFinishedExerciseScene(with title: String) {
        let viewController = FinishedExerciseViewController()
        viewController.setTitle = title
        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(viewController, animated: false)
        FinishedExerciseConfigurator.assembly(viewController: viewController)
    }
}
