//
//  DefaultWordSetModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum DefaultWordSetModel {
    
    enum FetchDefaultSets {
        
        struct Request { }
        
        struct Response {
            var defaultWordSetModel: DefaultWordSet
        }
        
        struct ViewModel {
            var sets: [WordSetModel]
        }
    }
}
