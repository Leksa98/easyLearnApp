//
//  SettingsRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

import UIKit

protocol SettingsRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToChooseLanguageScene()
}

final class SettingsRouter: SettingsRouterLogic {
    weak var navigationController: UINavigationController?
    
    func routeToChooseLanguageScene() {
        navigationController?.pushViewController(ChooseLanguageViewController(), animated: false)
    }
}
