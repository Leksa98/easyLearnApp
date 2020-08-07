//
//  DefaultWordSetConfiguration.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class DefaultWordSetListConfiguration {
    
    static func assembly(setName: String, setEmoji: String, words: [WordModel]) -> DefaultWordSetListViewController {
        
        let viewController = DefaultWordSetListViewController()
        viewController.presentWordSet(name: setName, emoji: setEmoji, words: words)
        let presenter = DefaultWordSetListPresenter()
        let interactor = DefaultWordSetListInteractor()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
