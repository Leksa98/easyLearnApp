//
//  TranslationModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

// MARK: - TranslationModel
struct TranslationModel: Codable {
    let head: Head
    let def: [Def]
}

// MARK: - Def
struct Def: Codable {
    let text: String
    let pos: String?
    let ts: String
    let tr: [Tr]
}

// MARK: - Tr
struct Tr: Codable {
    let text: String 
    let pos: String?
    let gen: String?
    let syn: [Syn]?
    let mean: [Mean]?
    let ex: [Ex]?
    let asp: String?
}

// MARK: - Ex
struct Ex: Codable {
    let text: String
    let tr: [Mean]
}

// MARK: - Mean
struct Mean: Codable {
    let text: String
}

// MARK: - Syn
struct Syn: Codable {
    let text: String
    let pos: String
    let gen, asp: String?
}

// MARK: - Head
struct Head: Codable {
}
