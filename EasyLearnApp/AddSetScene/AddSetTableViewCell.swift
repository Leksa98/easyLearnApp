//
//  AddSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class AddSetTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius = CGFloat(6)
    }
    
    // MARK: - Properties
    
    private var wordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextMedium(ofSize: 18)
        label.textColor = .blueSapphire
        return label
    }()
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = Locals.cornerRadius
        containerView.backgroundColor = UIColor.lightCyan
        return containerView
    }()
    
    
    private var translationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextRegular(ofSize: 16)
        label.textColor = .blueSapphire
        return label
    }()
    
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(viewModel: viewModel)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.addSubview(wordLabel)
        containerView.addSubview(translationLabel)
        containerView.layer.masksToBounds = true
        let bgColorView = UIView()
        bgColorView.layer.cornerRadius = Locals.cornerRadius
        bgColorView.backgroundColor = UIColor.persianGreen
        selectedBackgroundView = bgColorView
        
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            translationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            translationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 3),
            translationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(viewModel: WordModel) {
        wordLabel.text = viewModel.word.capitalizingFirstLetter()
        translationLabel.text = viewModel.translation.capitalizingFirstLetter()
    }
}
