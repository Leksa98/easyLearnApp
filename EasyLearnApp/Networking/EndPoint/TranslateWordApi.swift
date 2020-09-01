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
        return ["Content-Type": "application/json; charset=utf-8"]
    }
    
    var bodyParameters: Parameters? {
        switch self {
        case let .translate(word):
            let userDefaults = UserDefaults.standard
            let lang = (userDefaults.object(forKey: "lang") as? String) ?? "en"
            return ["key":"", "lang": "\(lang)-ru", "text":"\(word)"]
        }
    }
}
