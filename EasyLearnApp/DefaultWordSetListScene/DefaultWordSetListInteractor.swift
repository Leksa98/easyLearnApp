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
    var worker: (DataStorageWordSetSave & DataStorageWordSetEdit)?
    
    func downloadWordSet(request: DefaultWordSetListModel.DownloadWordSet.Request) {
        if let isAbleToSave = worker?.saveWordSet(name: request.name, emoji: request.emoji), isAbleToSave {
            for word in request.words {
                worker?.addWordtoSet(name: request.name, word: word.word, translation: word.translation)
            }
            presenter?.prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response(name: request.name, emoji: request.emoji))
        } else {
            presenter?.prepareForPresent(response: nil)
        }
    }
}
