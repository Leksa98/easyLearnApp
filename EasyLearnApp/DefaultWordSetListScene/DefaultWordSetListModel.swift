//
//  DefaultWordSetListModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 08.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

enum DefaultWordSetListModel {
    
    enum DownloadWordSet {
        
        struct Request {
            var name: String
            var emoji: String
            var words: [WordModel]
        }
        
        struct Response {
            var name: String
            var emoji: String
        }
        
        struct ViewModel {
            var alertTitleLabel: String
            var alertMessageLabel: String
        }
    }
}
