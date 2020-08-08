//
//  WordSetCardModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum WordSetCardModel {
    
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
}
