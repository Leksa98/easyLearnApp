//
//  AddSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordModel {
    var word: String
    var translation: String
    
    init(word: String, translation: String) {
        self.word = word
        self.translation = translation
    }
}
