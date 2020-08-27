//
//  WordSetTableInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 22.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AllWordSetTableBusinessLogic {
    func fetchStudySets(request: AllWordSetTableModel.FetchStudySets.Request)
    func deletefromCoreData(request: AllWordSetTableModel.DeleteSet.Request)
}

final class AllWordSetTableInteractor: AllWordSetTableBusinessLogic {
    
    var presenter: AllWordSetTablePresentationLogic?
    var worker: DataStorageAllWordSet?
    
    func fetchStudySets(request: AllWordSetTableModel.FetchStudySets.Request) {
        guard let sets = worker?.fetchAllWordSet() else {
            return
        }
        presenter?.presentSets(response: AllWordSetTableModel.FetchStudySets.Response(studySets: sets))
    }
    
    func deletefromCoreData(request: AllWordSetTableModel.DeleteSet.Request) {
        worker?.deleteWordSet(name: request.setName)
    }
}
