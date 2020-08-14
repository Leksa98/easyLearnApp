//
//  NewWordSetRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol NewWordSetRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToDefaultWordSetScene()
    func routeToAddSetScene()
}

final class NewWordSetRouter: NewWordSetRouterLogic {
    weak var navigationController: UINavigationController?
    
    func routeToDefaultWordSetScene() {
        let viewController = DefaultWordSetViewController()
        navigationController?.pushViewController(viewController, animated: false)
        DefaultWordSetConfigurator.assembly(viewController: viewController)
    }
    
    func routeToAddSetScene() {
        let viewController = AddSetViewController()
        navigationController?.pushViewController(viewController, animated: false)
        AddSetConfiguration.assembly(viewController: viewController)
    }
}
