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
        guard let url = URL(string: "https://api.jsonbin.io") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "/b/5f2a91c1dddf413f95bd5a3a/1"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json", "secret-key": "$2b$10$7bE1bmE7omk6Hwu4VwoOWeGvmkHN9NzBBxqlBC3z/KsKioWd4Arc."]
    }
}
