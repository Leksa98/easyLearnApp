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
        let languages = [LanguageModel(language: "English", flag: "🇬🇧", code: "en"),
                         LanguageModel(language: "German", flag: "🇩🇪", code: "de"),
                         LanguageModel(language: "French", flag: "🇫🇷", code: "fr"),
                         LanguageModel(language: "Spanish", flag: "🇪🇸", code: "es"),
                         LanguageModel(language: "Italian", flag: "🇮🇹", code: "it")]
        presenter?.prepareForPresent(response: ChooseLanguageModel.Language.Response(languages: languages))
    }
    
}
