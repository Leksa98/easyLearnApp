//
//  WordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordSetModel {
    
    // MARK: - Properties
    
    private let name: String
    private let progress: Float
    private let emoji: String
    private var words: [WordModel] = []
    
    var nameValue: String {
        return name
    }
    
    var progressValue: Float {
        return progress
    }
    
    var emojiValue: String {
        return emoji
    }
    
    var wordsValue: [WordModel] {
        return words
    }
    
    // MARK: - Initialization
    
    init(name: String, emoji: String, progress: Float = 0) {
        self.name = name
        self.progress = progress
        self.emoji = emoji
    }
    
    // MARK: - Public functions
    
    func addWord(newWord: WordModel) {
        words.append(newWord)
    }
}
