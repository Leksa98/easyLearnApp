//
//  ChooseLanguageModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class ChooseLanguageModel {
    
    // MARK: - Properties
    
    private let language: String
    private let flag: String
    private let code: String
    
    var languageValue: String {
        return language
    }
    
    var flagValue: String {
        return flag
    }
    
    var codeValue: String {
        return code
    }
    
    // MARK: - Initialization
    
    init(language: String, flag: String, code: String) {
        self.language = language
        self.flag = flag
        self.code = code
    }
}
