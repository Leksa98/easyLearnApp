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
        static let cornerRadius: CGFloat = 40
        static let textSize: CGFloat = 30
        static let numberOfLines = 0
        
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
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
        label.font = UIFont.sfProTextHeavy(ofSize: Locals.textSize)
        label.textColor = .white
        label.numberOfLines = Locals.numberOfLines
        label.textAlignment = .center
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public
    
    func setTextLabel(text: String) {
        label.text = text.capitalizingFirstLetter()
    }
}
