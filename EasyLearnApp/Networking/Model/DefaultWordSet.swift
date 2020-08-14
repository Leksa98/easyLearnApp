//
//  DefaultWordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation


/// Структура, содержащая дефолтные сеты
struct DefaultWordSet: Codable {
    let defaultSet: [DefaultSet]
}

/// Структура дефолтного сета
struct DefaultSet: Codable {
    let name, emoji: String
    let words: [WordToLearn]
}

/// Структура для слова из сета
struct WordToLearn: Codable {
    let wordToLearn, translation: String
}
