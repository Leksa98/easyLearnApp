//
//  WordStatisticsSection.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordStatisticsSection {
    
    private let name: String
    private let words: [WordModel]
    
    var nameValue: String {
        return name
    }
    
    var wordsValue: [WordModel] {
        return words
    }
    
    init(name: String, words: [WordModel]) {
        self.name = name
        self.words = words
    }
}
