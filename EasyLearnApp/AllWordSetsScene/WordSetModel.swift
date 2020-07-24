//
//  WordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordSetModel {
    
    private let name: String
    private let progress: Float
    private let emoji: String
    
    init(name: String, emoji: String, progress: Float = 0) {
        self.name = name
        self.progress = progress
        self.emoji = emoji
    }
    
    var nameValue: String {
        return name
    }
    
    var progressValue: Float {
        return progress
    }
    
    var emojiValue: String {
        return emoji
    }
}
