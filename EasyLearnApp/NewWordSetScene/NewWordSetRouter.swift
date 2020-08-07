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
        let vc = DefaultWordSetViewController()
        navigationController?.pushViewController(vc, animated: false)
        DefaultWordSetConfigurator.assembly(viewController: vc)
    }
    
    func routeToAddSetScene() {
        navigationController?.pushViewController(AddSetViewController(), animated: false)
    }
}
