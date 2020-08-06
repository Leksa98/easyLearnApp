//
//  TranslateEndPoint.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

public enum TranslateWordApi {
    case translate(word: String)
}

extension TranslateWordApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://dictionary.yandex.net/api/v1/dicservice.json") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "/lookup"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: bodyParameters, additionHeaders: headers)
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var bodyParameters: Parameters? {
        switch self {
        case let .translate(word):
            let userDefaults = UserDefaults.standard
            let lang = (userDefaults.object(forKey: "lang") as? String) ?? "en"
            return ["key":"dict.1.1.20200630T173620Z.1de60fec798b1c41.ad15bcbb0be94e7eab2543d4b8f4fec39069c902", "lang": "\(lang)-ru", "text":"\(word)"]
        }
    }
}
