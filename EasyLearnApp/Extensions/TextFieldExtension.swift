//
//  TextFieldExtension.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UITextField {
    open override var textInputMode: UITextInputMode? {
        if self.placeholder == "Set Emoji" {
            return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
        }
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == NSLocale.current.languageCode }.first ?? super.textInputMode
    }
}
