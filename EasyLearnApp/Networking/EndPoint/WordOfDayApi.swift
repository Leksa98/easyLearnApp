//
//  WordOfDayApi.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

public enum WordOfDayApi {
    case fetchWordOfDay
}

extension WordOfDayApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://api.wordnik.com/v4/words.json") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "/wordOfTheDay"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionHeaders: headers)
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json", "api_key": ""]
    }
}
