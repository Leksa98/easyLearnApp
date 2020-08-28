//
//  AddWordInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol FetchWordTranslations {
    func fetchWordTranslations(request: AddWordModel.WordTranslations.Request)
}

class AddWordInteractor: FetchWordTranslations {
    
    var presenter: PresentTranslations?
    var worker: TranslationParse?
    
    func fetchWordTranslations(request: AddWordModel.WordTranslations.Request) {
        worker?.getWordMeaning(word: request.word) { translation, error in
            if let error = error {
                print(error)
            }
            if let translation = translation {
                self.presenter?.presentTranslations(response: AddWordModel.WordTranslations.Response(translations: translation))
            }
        }
    }

}
