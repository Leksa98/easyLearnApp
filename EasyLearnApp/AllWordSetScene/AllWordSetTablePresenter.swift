//
//  WordSetTablePresenter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 22.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AllWordSetTablePresentationLogic {
    func presentSets(response: AllWordSetTableModel.FetchStudySets.Response)
}

final class AllWordSetTablePresenter: AllWordSetTablePresentationLogic {
    
    weak var viewController: AllWordSetTableShow?
    
    func presentSets(response: AllWordSetTableModel.FetchStudySets.Response) {
        var studySet: [WordSetModel] = []
        response.studySets.forEach { set in
            if let setName = set.name, let setEmoji = set.emoji {
                studySet.append(WordSetModel(name: setName, emoji: setEmoji, progress: Float(set.progress)))
            }
        }
        viewController?.showWordSets(viewModel: AllWordSetTableModel.FetchStudySets.ViewModel(studySets: studySet))
    }
}
