//
//  DefaultWordSetListInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol DefaultWordSetListBusinessLogic {
    func downloadWordSet(request: DefaultWordSetListModel.DownloadWordSet.Request)
}

final class DefaultWordSetListInteractor: DefaultWordSetListBusinessLogic {
    
    var presenter: DefaultWordSetListPresentationLogic?
    
    func downloadWordSet(request: DefaultWordSetListModel.DownloadWordSet.Request) {
        let dataHandler = DataHandler()
        dataHandler.saveWordSet(name: request.name, emoji: request.emoji)
        for word in request.words {
            dataHandler.addWordtoSet(name: request.name, word: word.word, translation: word.translation)
        }
        presenter?.prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response(name: request.name, emoji: request.emoji))
    }
}
