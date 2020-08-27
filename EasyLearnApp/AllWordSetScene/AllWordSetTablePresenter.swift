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
        viewController?.showWordSets(viewModel: AllWordSetTableModel.FetchStudySets.ViewModel(studySets: response.studySets))
    }
}
