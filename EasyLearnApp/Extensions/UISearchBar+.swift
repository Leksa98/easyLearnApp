//
//  SearchBarExtension.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setPlaceholderTextColorTo(color: UIColor) {
        if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = color
            textFieldInsideSearchBar.font = UIFont.sfProTextMedium(ofSize: 15) ?? UIFont.systemFont(ofSize: 15)
            if let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel {
                textFieldInsideSearchBarLabel.textColor = color
            }
        }
    }
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            if let searchField = self.value(forKey: "searchField") as? UITextField {
                return searchField
            }
        }
        return nil
    }
}
