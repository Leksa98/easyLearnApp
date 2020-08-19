//
//  WordOfDayParser.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordOfDayParser {
    
    private let networkManager = NetworkManager()
    
    func fetchWordOfDay(completion: @escaping (_ wordOfDay: WordOfDay?, _ error: String?) -> ()) {
        networkManager.fetchWordOfDay { apiResponse, error in
            if let error = error {
                completion(nil, error)
            }
            if let apiResponse = apiResponse {
                completion(self.parseWordOfDay(response: apiResponse), nil)
            }
        }
    }
    
    private func parseWordOfDay(response: WordOfDayModelNetwork) -> WordOfDay {
        var definitions: [WordDefinition] = []
        response.definitions.forEach { definition in
            definitions.append(WordDefinition(partOfSpeech: definition.partOfSpeech, definition: definition.text))
        }
        var examples: [String] = []
        response.examples.forEach { example in
            examples.append(example.text)
        }
        return WordOfDay(word: response.word, date: response.pdd, note: response.note, definition: definitions, example: examples)
    }
}
