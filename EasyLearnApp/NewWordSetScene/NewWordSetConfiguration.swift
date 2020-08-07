//
//  NewWordSetConfiguration.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class NewWordSetConfiguration {
    
    static func assembly(viewController: NewWordSetViewController) {
        let router = NewWordSetRouter()
        viewController.router = router
        router.navigationController = viewController.navigationController
    }
}
