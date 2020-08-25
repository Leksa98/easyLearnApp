//
//  ChooseLanguageTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ChooseLanguageTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum Locals {
        static let labelSize: CGFloat = 18
        static let flagSize: CGFloat = 30
        
        static let topAnchor: CGFloat = 10
        static let bottomAnchor: CGFloat = -10
        static let leadingAnchor: CGFloat = 20
        static let trailingAnchor: CGFloat = -20
        static let distanceBetweenLabels: CGFloat = 10
    }
    
    // MARK: - Properties
    
    private var languageLabel = UILabel()
    private var flagLabel = UILabel()
    var viewModel: LanguageModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .none
        tintColor = .blueSapphire
        languageLabel.font = UIFont.sfProTextMedium(ofSize: Locals.labelSize)
        flagLabel.font = .systemFont(ofSize: Locals.flagSize)
        addSubview(languageLabel)
        addSubview(flagLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            flagLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.topAnchor),
            flagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.bottomAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: Locals.distanceBetweenLabels),
            languageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.topAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update content
    
    private func updateContent(viewModel: LanguageModel) {
        languageLabel.text = viewModel.languageValue
        flagLabel.text = viewModel.flagValue
    }
}
