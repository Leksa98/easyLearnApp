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
    
    func saveWordSetInCoreData(request: AddSetModel.SaveWordSet.Request) {
        let dataHandler = DataHandler()
        dataHandler.saveWordSet(name: request.name, emoji: request.emoji)
        request.words.forEach { word in
            dataHandler.addWordtoSet(name: request.name, word: word.word, translation: word.translation)
        }
        presenter?.prepareForPresent(response: AddSetModel.SaveWordSet.Response(name: request.name, emoji: request.emoji))
    }
}
