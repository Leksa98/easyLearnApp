//
//  WordSetTableRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AllWordSetTableRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToWordSetDetails(with title: String)
}

final class AllWordSetTableRouter: AllWordSetTableRouterLogic {
    
    weak var navigationController: UINavigationController?
    
    func routeToWordSetDetails(with title: String) {
        let viewController = WordSetViewController()
        viewController.title = title
        navigationController?.pushViewController(viewController, animated: true)
        WordSetConfigurator.assembly(viewController: viewController)
    }
}
