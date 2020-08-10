//
//  UIColor+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 10.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
    
    static let customPurple = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
    
    static let customLightBlue = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
    
    static let customDarkPurple = UIColor(cgColor: CGColor(srgbRed: 84.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 1))
    
    static let customGreen = UIColor(cgColor: CGColor(srgbRed: 85.0/255.0, green: 180.0/255.0, blue: 88.0/255.0, alpha: 1))
    
    static let customRed = UIColor(cgColor: CGColor(srgbRed: 206.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1))
    
    static let textFieldColor = UIColor(cgColor: CGColor(srgbRed: 196.0/255.0, green: 198.0/255.0, blue: 212.0/255.0, alpha: 1))
    
    static let placeholderColor = UIColor(cgColor: CGColor(srgbRed: 112.0/255.0, green: 99.0/255.0, blue: 134.0/255.0, alpha: 1))
    
    static let selectedBackgroundColor = UIColor(cgColor: CGColor(srgbRed: 202.0/255.0, green: 192.0/255.0, blue: 216.0/255.0, alpha: 1))
    
    static let containerViewBackgroundColor = UIColor(cgColor: CGColor(srgbRed: 181.0/255.0, green: 166.0/255.0, blue: 201.0/255.0, alpha: 1))
}
