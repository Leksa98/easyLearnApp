//
//  ChooseLanguageInteractor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol ChooseLanguageBusinessLogic {
    func loadLanguages()
}

final class ChooseLanguageInteractor: ChooseLanguageBusinessLogic {
    
    var presenter: ChooseLanguagePresentationLogic?
    
    func loadLanguages() {
        let languages = [ChooseLanguageModel(language: "English", flag: "🇬🇧", code: "en"),
                         ChooseLanguageModel(language: "German", flag: "🇩🇪", code: "de"),
                         ChooseLanguageModel(language: "French", flag: "🇫🇷", code: "fr"),
                         ChooseLanguageModel(language: "Spanish", flag: "🇪🇸", code: "es"),
                         ChooseLanguageModel(language: "Italian", flag: "🇮🇹", code: "it"),
                         ChooseLanguageModel(language: "Polish", flag: "🇵🇱", code: "pl"),
                         ChooseLanguageModel(language: "Turkish", flag: "🇹🇷", code: "tr")]
        presenter?.prepareForPresent(languages: languages)
    }
    
}
