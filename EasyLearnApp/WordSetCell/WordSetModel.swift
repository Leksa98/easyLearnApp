//
//  WordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

final class WordSetModel {
    
    private let name: String
    private let progress: Float
    
    init(name: String, progress: Float) {
        self.name = name
        self.progress = progress
    }
    
    var nameValue: String {
        return name
    }
    
    var progressValue: Float {
        return progress
    }
}
