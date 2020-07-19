//
//  AddWordInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AddWordInput {
    func showTranslations(word: String)
}

class AddWordInteractor: AddWordInput {
    
    func showTranslations(word: String) {
        let viewController = AddWordViewController()
        let translationMeaningsParser = TranslationMeaningsParser()
        translationMeaningsParser.getWordMeaning(word: word) { translation, error in
            if let error = error {
                print(error)
            }
            if let translation = translation {
                viewController.update(trans: translation)
            }
        }
    }

}
