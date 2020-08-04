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
    private var words: [WordModel]
    private let progress: Double
    
    var nameValue: String {
        return name
    }
    
    var wordsValue: [WordModel] {
        return words
    }
    
    var progressValue: Double {
        return progress
    }
    
    init(name: String, words: [WordModel], progress: Double = 0.0) {
        self.name = name
        self.words = words
        self.progress = progress
    }
    
    func appendWord(word: WordModel) {
        words.append(word)
    }
}
