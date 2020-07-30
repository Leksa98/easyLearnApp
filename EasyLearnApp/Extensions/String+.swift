//
//  String+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
