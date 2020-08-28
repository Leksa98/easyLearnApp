//
//  AddSetInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol AddSetBusinessLogic {
    func saveWordSetInCoreData(request: AddSetModel.SaveWordSet.Request)
}

final class AddSetInteractor: AddSetBusinessLogic {
    
    var presenter: AddSetPresentationLogic?
    var worker: (DataStorageWordSetEdit & DataStorageWordSetSave)?
    
    func saveWordSetInCoreData(request: AddSetModel.SaveWordSet.Request) {
        if let isAbleToSave = worker?.saveWordSet(name: request.name, emoji: request.emoji), isAbleToSave {
            request.words.forEach { word in
                worker?.addWordtoSet(name: request.name, word: word.word, translation: word.translation)
            }
            presenter?.prepareForPresent(response: AddSetModel.SaveWordSet.Response(name: request.name, emoji: request.emoji, isAlreadyExist: false))
        } else {
             presenter?.prepareForPresent(response: AddSetModel.SaveWordSet.Response(name: request.name, emoji: request.emoji, isAlreadyExist: true))
        }
    }
}
