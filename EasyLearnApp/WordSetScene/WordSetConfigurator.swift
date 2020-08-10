//
//  WordSetConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetConfigurator {
    
    static func assembly(viewController: WordSetViewController) {
        let router = WordSetRouter()
        viewController.router = router
        router.navigationController = viewController.navigationController
    }
}
