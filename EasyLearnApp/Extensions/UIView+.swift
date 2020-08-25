//
//  UIView+.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

extension UIView {
    func addBlur() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.alpha = 0.7
        self.addSubview(visualEffectView)
    }
}
