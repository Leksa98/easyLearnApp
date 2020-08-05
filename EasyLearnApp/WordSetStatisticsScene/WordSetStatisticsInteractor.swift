//
//  WordSetStatisticsInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetStatisticsBusinessLogic {
    func fetchWords(setName: String)
}

final class WordSetStatisticsInteractor: WordSetStatisticsBusinessLogic {
    
    var presenter: WordSetStatisticsPresentationLogic?
    
    func fetchWords(setName: String) {
        let dataHandler = DataHandler()
        let wordArray = dataHandler.fetchWords(from: setName)
        presenter?.prepareForPresent(wordDictionary: wordArray)
    }
}
