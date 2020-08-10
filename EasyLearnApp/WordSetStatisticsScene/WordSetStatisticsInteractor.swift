//
//  WordSetStatisticsInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetStatisticsBusinessLogic {
    func fetchWords(request: WordSetStatisticsModel.FetchWordSet.Request)
}

final class WordSetStatisticsInteractor: WordSetStatisticsBusinessLogic {
    
    var presenter: WordSetStatisticsPresentationLogic?
    
    func fetchWords(request: WordSetStatisticsModel.FetchWordSet.Request) {
        let dataHandler = DataHandler()
        let wordArray = dataHandler.fetchWords(from: request.setName)
        presenter?.prepareForPresent(response: WordSetStatisticsModel.FetchWordSet.Response(wordsArray: wordArray))
    }
}
