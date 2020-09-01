//
//  ChooseLanguageInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol ChooseLanguageBusinessLogic {
    func loadLanguages(request: ChooseLanguageModel.Language.Request)
}

final class ChooseLanguageInteractor: ChooseLanguageBusinessLogic {
    
    var presenter: ChooseLanguagePresentationLogic?
    
    func loadLanguages(request: ChooseLanguageModel.Language.Request) {
        let languages = [LanguageModel(language: NSLocalizedString("english_language", comment: ""), flag: "🇬🇧", code: "en"),
                         LanguageModel(language: NSLocalizedString("german_language", comment: ""), flag: "🇩🇪", code: "de"),
                         LanguageModel(language: NSLocalizedString("french_language", comment: ""), flag: "🇫🇷", code: "fr"),
                         LanguageModel(language: NSLocalizedString("spanish_language", comment: ""), flag: "🇪🇸", code: "es"),
                         LanguageModel(language: NSLocalizedString("italien_language", comment: ""), flag: "🇮🇹", code: "it")]
        presenter?.prepareForPresent(response: ChooseLanguageModel.Language.Response(languages: languages))
    }
    
}
