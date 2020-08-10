//
//  ButtonWithRoundCorners.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ButtonWithRoundCorners: UIButton {
    
    // MARK: - Initialization
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = UIColor.customPurple
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
