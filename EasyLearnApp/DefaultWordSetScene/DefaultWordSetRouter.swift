//
//  DefaultWordSetRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol DefaultWordSetRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToDefaultWordSetList(name: String, emoji: String, words: [WordModel])
}

final class DefaultWordSetRouter: DefaultWordSetRouterLogic {
    weak var navigationController: UINavigationController?
    
    func routeToDefaultWordSetList(name: String, emoji: String, words: [WordModel]) {
        let vc: DefaultWordSetListDataSource = DefaultWordSetListViewController()
        vc.presentWordSet(name: name, emoji: emoji, words: words)
        navigationController?.pushViewController(vc as! UIViewController, animated: false)
    }
}
