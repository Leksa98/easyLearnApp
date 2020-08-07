//
//  DefaultWordSetListPresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetListPresentationLogic {
    func prepareForPresent(name: String, emoji: String)
}

final class DefaultWordSetListPresenter: DefaultWordSetListPresentationLogic {
    
    weak var viewController: DefaultWordSetListSaveNotification?
    
    func prepareForPresent(name: String, emoji: String) {
        viewController?.showSaveAlert(name: name, emoji: emoji)
    }
}
