//
//  AddWordInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol FetchWordTranslations {
    func fetchWordTranslations(word: String)
}

class AddWordInteractor: FetchWordTranslations {
    
    var presenter: PresentTranslations?
    
    func fetchWordTranslations(word: String) {
        let translationMeaningsParser = TranslationMeaningsParser()
        translationMeaningsParser.getWordMeaning(word: word) { translation, error in
            if let error = error {
                print(error)
            }
            if let translation = translation {
                self.presenter?.presentTranslations(trans: translation)
            }
        }
    }

}
