//
//  WordOfDay.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

class WordOfDay {
    private let word: String
    private let date: String
    private let note: String
    private let definition: [WordDefinition]
    private let example: [String]
    
    var wordValue: String {
        return word
    }
    var definitionValue: [WordDefinition] {
        return definition
    }
    var dateValue: String {
        return date
    }
    var noteValue: String {
        return note
    }
    var exampleValue: [String] {
        return example
    }
    
    init(word: String, date: String, note: String, definition: [WordDefinition], example: [String]) {
        self.word = word
        self.date = date
        self.note = note
        self.definition = definition
        self.example = example
    }
}

class WordDefinition {
    private let partOfSpeech: String
    private let definition: String
    
    var partOfSpeechValue: String {
        return partOfSpeech
    }
    var definitionValue: String {
        return definition
    }
    
    init(partOfSpeech: String, definition: String) {
        self.partOfSpeech = partOfSpeech
        self.definition = definition
    }
}
