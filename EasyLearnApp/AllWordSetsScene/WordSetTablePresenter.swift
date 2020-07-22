//
//  WordSetTablePresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 22.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol PresentSets {
    func presentSets(sets: [WordSet])
}

final class WordSetTablePresenter: PresentSets {
    
    var viewController: ShowWordSets?
    
    func presentSets(sets: [WordSet]) {
        var studySet: [WordSetModel] = []
        sets.forEach { set in
            studySet.append(WordSetModel(name: set.name!, emoji: set.emoji!))
        }
        viewController?.showWordSets(sets: studySet)
    }
}
