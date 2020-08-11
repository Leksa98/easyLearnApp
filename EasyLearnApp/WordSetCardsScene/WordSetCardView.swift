//
//  WordSetCardView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class WordSetCardView: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius = CGFloat(40)
    }
    
    // MARK: - Property
    
    private var label = UILabel()
    private var image = UIImageView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        configureLabel()
        backgroundColor = UIColor.blueSapphire
        layer.cornerRadius = Locals.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureLabel() {
        label.font = UIFont.sfProTextHeavy(ofSize: 40)
        label.textColor = .white
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public
    
    func setTextLabel(text: String) {
        label.text = text.capitalizingFirstLetter()
    }
    
}
