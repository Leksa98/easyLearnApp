//
//  UIApplication+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UIApplication {
    func takeScreenshot() -> UIImage? {
        var screenshotImage: UIImage?
        let scale = UIScreen.main.scale
        if let layer = UIApplication.shared.keyWindow?.layer {
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            layer.render(in:context)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return screenshotImage
    }
}
