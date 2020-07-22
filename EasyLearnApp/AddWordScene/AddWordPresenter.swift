//
//  AddWordPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol PresentTranslations {
    func presentTranslations(trans: [String])
}

final class AddWordPresenter: PresentTranslations {
    
    var viewController: UpdateTranslations?
    
    func presentTranslations(trans: [String]) {
        viewController?.updateTranslations(trans: trans)
    }
}
