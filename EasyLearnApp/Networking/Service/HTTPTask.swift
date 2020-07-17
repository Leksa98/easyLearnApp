//
//  HTTPTask.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

public typealias HTTPHeaders = [String:String]

/// Request Pararmeters configuration
public enum HTTPTask {
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
