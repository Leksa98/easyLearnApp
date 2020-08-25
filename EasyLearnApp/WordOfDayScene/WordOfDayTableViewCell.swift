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
        static let textSize: CGFloat = 16
        static let numberOflines = 0
        static let distanceBetweenLabels: CGFloat = 10
        static let bottomAnchor: CGFloat = -10
    }
    
    // MARK: - Properties
    
    private var partOfSpeechLabel = UILabel()
    private var definitionLabel = UILabel()
    var viewModel: String? {
        didSet {
            if let viewModel = viewModel {
                updateContent(viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(definitionLabel)
    
        definitionLabel.font = UIFont.sfProTextMedium(ofSize: Locals.textSize)
        definitionLabel.numberOfLines = Locals.numberOflines
        definitionLabel.textColor = .customDarkGray
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.distanceBetweenLabels),
            definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            definitionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update content
    
    private func updateContent(viewModel: String) {
        definitionLabel.text = viewModel
    }
}
