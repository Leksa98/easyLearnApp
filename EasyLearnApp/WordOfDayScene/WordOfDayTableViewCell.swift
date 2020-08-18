//
//  WordOfDayTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordOfDayTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum Locals {
        static let textSize: CGFloat = 18
        static let numberOflines = 0
        static let distanceBetweenLabels: CGFloat = 10
        static let bottomAnchor: CGFloat = -10
    }
    
    // MARK: - Properties
    
    private var partOfSpeechLabel = UILabel()
    private var definitionLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(partOfSpeechLabel)
        addSubview(definitionLabel)
        
        partOfSpeechLabel.text = "noun"
        partOfSpeechLabel.font = UIFont.sfProTextMediumItalic(ofSize: Locals.textSize)
        
        definitionLabel.text = "In the law of wills, the determination of what happens when property left under a will is no longer in the testator's estate when the testator dies."
        definitionLabel.font = UIFont.sfProTextMedium(ofSize: Locals.textSize)
        definitionLabel.numberOfLines = Locals.numberOflines
        
        partOfSpeechLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            partOfSpeechLabel.topAnchor.constraint(equalTo: topAnchor),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            partOfSpeechLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            definitionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
