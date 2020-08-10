//
//  WordSetListModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum WordSetListModel {
    
    enum FetchWordSet {
        
        struct Request {
            var setName: String
        }
        
        struct Response {
            var words: [WordModel]
        }
        
        struct ViewModel {
            var words: [WordModel]
        }
    }
    
    enum AddWordToSet {
        
        struct Request {
            var setName: String
            var word: WordModel
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum DeleteWordFromSet {
        
        struct Request {
            var set: String
            var word: String
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
}
