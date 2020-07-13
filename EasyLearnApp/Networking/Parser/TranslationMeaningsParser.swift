//
//  TranslationMeaningsParser.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 13.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

class TranslationMeaningsParser {
    
    func getWordMeaning(translation: TranslationModel) -> [String]? {
        var meanings: [String]? = []
        for def in translation.def {
            for tr in def.tr {
                meanings?.append(tr.text)
            }
        }
        return meanings
    }
}
