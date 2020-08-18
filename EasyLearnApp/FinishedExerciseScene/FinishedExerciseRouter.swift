//
//  FinishedExerciseRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 17.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol FinishedExerciseRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeBack()
    func learnAgain(with title: String)
}


final class FinishedExerciseRouter: FinishedExerciseRouterLogic {
    
    weak var navigationController: UINavigationController?
    
    func routeBack() {
        navigationController?.popViewController(animated: false)
    }
    
    func learnAgain(with title: String) {
        let viewController = WordSetLearnViewController()
        viewController.title = title
        viewController.setName = title
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.viewControllers.first(where: {$0 is FinishedExerciseViewController})?.removeFromParent()
        WordSetLearnConfigurator.assembly(viewController: viewController)
        viewController.interactor?.fetchWords(request: WordSetLearnModel.FetchWordSet.Request(setName: title))
    }
}
