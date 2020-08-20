//
//  WordOfDayModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum WordOfDayModel {
    
    enum FetchWordOfDay {
        
        struct Request {}
        
        struct Response {
            var wordOfDay: WordOfDay
        }
        
        struct ViewModel {
            var wordOfDay: WordOfDay
        }
    }
}
