//
//  WordSetTableInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 22.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol FetchingStudySets {
    func fetchStudySets()
    func deletefromCoreData(setName: String)
}

final class WordSetTableInteractor: FetchingStudySets {
    
    var presenter: PresentSets?
    
    func fetchStudySets() {
        let dataHandler = DataHandler()
        guard let sets = dataHandler.fetchAllWordSetRecord() else {
            return
        }
        presenter?.presentSets(sets: sets)
    }
    
    func deletefromCoreData(setName: String) {
        let dataHandler = DataHandler()
        dataHandler.deleteWordSet(name: setName)
    }
}
