//
//  ButtonWithRoundCorners.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ButtonWithRoundCorners: UIButton {
    
    // MARK: - Constants
    
    private enum Locals {
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
    }
    
    // MARK: - Initialization
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = Locals.buttonColor
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
