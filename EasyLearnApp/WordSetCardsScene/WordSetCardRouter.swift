//
//  WordSetCardRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 10.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetCardRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeBack()
}

final class WordSetCardRouter: WordSetCardRouterLogic {
    
    weak var navigationController: UINavigationController?
    
    func routeBack() {
        navigationController?.popViewController(animated: false)
    }
}
