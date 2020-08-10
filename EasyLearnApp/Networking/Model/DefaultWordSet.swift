//
//  DefaultWordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

// MARK: - DefaultWordSet
struct DefaultWordSet: Codable {
    let defaultSet: [DefaultSet]
}

// MARK: - DefaultSet
struct DefaultSet: Codable {
    let name, emoji: String
    let words: [WordToLearn]
}

// MARK: - WordToLearn
struct WordToLearn: Codable {
    let wordToLearn, translation: String
}
