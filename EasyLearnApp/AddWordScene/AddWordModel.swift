//
//  AddWordModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 10.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum AddWordModel {
    
    enum WordTranslations {
        
        struct Request {
            var word: String
        }
        
        struct Response {
            var translations: [String]
        }
        
        struct ViewModel {
            var translations: [String]
        }
    }
}
