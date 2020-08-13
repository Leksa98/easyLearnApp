//
//  TranslationMeaningsParser.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 13.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation


/// Парсинг запроса на перевод слова
final class TranslationMeaningsParser {
    
    private let networkManager = NetworkManager()
    
    
    /// Получение вариантов перевода слова
    /// - Parameters:
    ///   - word: слово, которое необходимо перевести
    ///   - completion: принимает следующие параметры: translation - массив, состоящий из различных переводов слова, error - ошибка
    /// - Returns:
    func getWordMeaning(word: String, completion: @escaping (_ translation: [String]?, _ error: String?) -> ()) {
        networkManager.translateWord(word: word) { apiResponse, error in
            if let error = error {
                completion(nil, error)
            }
            if let apiResponse = apiResponse {
                completion(self.getTranslation(translation: apiResponse), nil)
            }
        }
    }
    
    private func getTranslation(translation: TranslationModel) -> [String]? {
        var meanings: [String]? = []
        for def in translation.def {
            for tr in def.tr {
                meanings?.append(tr.text)
            }
        }
        return meanings
    }
}
