//
//  DefaultWordSetModelApi.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

public enum DefaultWordSetModelApi {
    case fetchDefaultWordSet
}

extension DefaultWordSetModelApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.jsonbin.io") else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        let language = (UserDefaults.standard.object(forKey: "selectedLanguage") as? String) ?? "English"
        switch language {
        case "German":
            return "/b/5f3febd2514ec5112d0b1ff4"
        case "French":
            return "/b/5f4014884d8ce411137dc110"
        case "Spanish":
            return "/b/5f40159d993a2e110d336440"
        case "Italian":
            return "/b/5f4017f3993a2e110d3365db"
        default:
            return "/b/5f2a91c1dddf413f95bd5a3a/1"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json", "secret-key": ""]
    }
}
