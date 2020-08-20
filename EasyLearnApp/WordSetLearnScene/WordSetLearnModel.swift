//
//  WordSetLearnModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum WordSetLearnModel {
    
    enum FetchWordSet {
        
        struct Request {
            var setName: String
        }
        
        struct Response {
            var wordsArray: [WordModel]
        }
        
        struct ViewModel {
            var wordsArray: [WordModel]
        }
    }
    
    enum EditWordProgress {
        
        struct Request {
            var setName: String
            var word: String
            var progressChange: Double
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
}
