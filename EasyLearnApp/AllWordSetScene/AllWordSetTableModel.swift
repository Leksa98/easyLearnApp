//
//  AllWordSetTableModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum AllWordSetTableModel {
    
    enum FetchStudySets {
        
        struct Request { }
        
        struct Response {
            var studySets: [WordSet]
        }
        
        struct ViewModel {
            var studySets: [WordSetModel]
        }
    }
    
    enum DeleteSet {
        
        struct Request {
            var setName: String
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
}
