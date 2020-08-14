//
//  AddSetRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AddSetRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToAddWordScene(viewController: UIViewController)
}

final class AddSetRouter: AddSetRouterLogic {
    weak var navigationController: UINavigationController?
    
    func routeToAddWordScene(viewController: UIViewController) {
        let viewControllerToShow = AddWordConfigurator.assembly()
        viewControllerToShow.delegete = viewController as? AddWordToSetDataStore
        viewController.present(viewControllerToShow, animated: true, completion: nil)
    }
}
