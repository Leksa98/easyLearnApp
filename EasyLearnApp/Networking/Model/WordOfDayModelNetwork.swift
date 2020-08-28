//
//  WordOfDayModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

// MARK: - WordOfDay
struct WordOfDayModelNetwork: Codable {
    let id, word: String
    let contentProvider: ContentProvider
    let definitions: [Definition]
    let publishDate: String
    let examples: [ExampleWordOfDay]
    let pdd: String
    let htmlExtra: JSONNull?
    let note: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case word, contentProvider, definitions, publishDate, examples, pdd, htmlExtra, note
    }
}

// MARK: - ContentProvider
struct ContentProvider: Codable {
    let name: String
    let id: Int
}

// MARK: - Definition
struct Definition: Codable {
    let source, text: String
    let note: JSONNull?
    let partOfSpeech: String
}

// MARK: - Example
struct ExampleWordOfDay: Codable {
    let url: String?
    let title, text: String
    let id: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
