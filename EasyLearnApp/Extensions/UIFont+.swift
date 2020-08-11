//
//  UIFont+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 11.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UIFont {
    open class func sfProTextHeavy(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Heavy", size: ofSize)
    }
    
    open class func sfProTextMedium(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Medium", size: ofSize)
    }
    
    open class func sfProTextRegular(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "SFProText-Regular", size: ofSize)
    }
}
