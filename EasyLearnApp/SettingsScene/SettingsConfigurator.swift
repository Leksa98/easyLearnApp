//
//  SettingsConfiguration.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class SettingsConfigurator {
    
    static func assembly(viewController: SettingsViewController) {
        
        let router = SettingsRouter()
        viewController.router = router
        router.navigationController = viewController.navigationController
    }
}
