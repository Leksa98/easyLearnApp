//
//  UIColor+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 10.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let customGreen = UIColor(cgColor: CGColor(srgbRed: 85.0/255.0, green: 180.0/255.0, blue: 88.0/255.0, alpha: 1))
    
    static let customRed = UIColor(cgColor: CGColor(srgbRed: 206.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1))
    
    static let blueSapphire = UIColor(hexString: "05668D")
    
    static let metallicSeaweed = UIColor(hexString: "028090")
    
    static let persianGreen = UIColor(hexString: "00A896")
    
    static let mountainMeadow = UIColor(hexString: "02C39A")
    
    static let paleSpringBud = UIColor(hexString: "F0F3BD")
    
    static let lightCyan = UIColor(hexString: "CAE9E6")
}
