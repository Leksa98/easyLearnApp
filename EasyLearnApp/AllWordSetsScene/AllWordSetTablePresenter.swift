//
//  WordSetTablePresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 22.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AllWordSetTablePresentationLogic {
    func presentSets(sets: [WordSet])
}

final class AllWordSetTablePresenter: AllWordSetTablePresentationLogic {
    
    weak var viewController: AllWordSetTableShow?
    
    func presentSets(sets: [WordSet]) {
        var studySet: [WordSetModel] = []
        sets.forEach { set in
            if let setName = set.name, let setEmoji = set.emoji {
                studySet.append(WordSetModel(name: setName, emoji: setEmoji, progress: Float(set.progress)))
            }
        }
        viewController?.showWordSets(sets: studySet)
    }
}
