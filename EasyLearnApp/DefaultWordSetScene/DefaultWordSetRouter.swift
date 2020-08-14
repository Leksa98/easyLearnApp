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
        let viewController = DefaultWordSetListConfiguration.assembly(setName: name, setEmoji: emoji, words: words)
        navigationController?.pushViewController(viewController, animated: false)
    }
}
