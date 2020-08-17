//
//  FinishedExerciseConfigurator.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 17.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class FinishedExerciseConfigurator {
    
    static func assembly(viewController: FinishedExerciseViewController) {
        
        let router = FinishedExerciseRouter()
        
        viewController.router = router
        router.navigationController = viewController.navigationController
    }
}
