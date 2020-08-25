//
//  AboutAppModel.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

enum AboutAppModel {
    enum AppDescription {
        struct Request { }
        
        struct Response {
            var description: String
        }
        
        struct ViewModel {
            var description: String
        }
    }
}
