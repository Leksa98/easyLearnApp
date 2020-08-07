//
//  AddSetPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AddSetPresentationLogic {
    func prepareForPresent(name: String, emoji: String)
}

final class AddSetPresenter: AddSetPresentationLogic {
    
    weak var viewController: AddSetSavedNotification?
    
    func prepareForPresent(name: String, emoji: String) {
        viewController?.showSavedAlert(name: name, emoji: emoji)
    }
}
