//
//  TranslationModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

/// Структура содержащая словарь, генерируемая для результата запроса
struct TranslationModel: Codable {
    let head: Head
    let def: [Def]
}

/// Структура словаря
struct Def: Codable {
    let text: String
    let pos: String?
    let ts: String
    let tr: [Translation]
}

/// Струкрура перевода слова
struct Translation: Codable {
    let text: String 
    let pos: String?
    let gen: String?
    let syn: [Synonym]?
    let mean: [Meaning]?
    let ex: [Example]?
    let asp: String?
}

/// Структура для примера к слову
struct Example: Codable {
    let text: String
    let tr: [Meaning]
}

/// Структура для значения слова
struct Meaning: Codable {
    let text: String
}

/// Структура для синонима к слову
struct Synonym: Codable {
    let text: String
    let pos: String
    let gen, asp: String?
}

/// Head
struct Head: Codable { }
