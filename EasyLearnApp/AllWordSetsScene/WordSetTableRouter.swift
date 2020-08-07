//
//  WordSetTableRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetTableRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToWordSetDetails(with title: String)
}

final class WordSetTableRouter: WordSetTableRouterLogic {
    weak var navigationController: UINavigationController?
    
    func routeToWordSetDetails(with title: String) {
        let vc = WordSetViewController()
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}
