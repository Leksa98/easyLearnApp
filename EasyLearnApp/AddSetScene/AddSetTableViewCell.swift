//
//  AddSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 19.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 6
        static let numberOfLines = 0
        static let wordLabelSize: CGFloat = 18
        static let translationLabelSize: CGFloat = 16
        
        static let containerViewLeadingAnchor: CGFloat = 10
        static let containerViewTrailingAnchor: CGFloat = -10
        static let containerViewTopAnchor: CGFloat = 10
        static let containerViewBottomAnchor: CGFloat = -10
        
        static let labelLeadingAnchor: CGFloat = 20
        static let labelTrailingAnchor: CGFloat = -20
        static let labelBottomAnchor: CGFloat = -20
        static let labelTopAnchor: CGFloat = 20
        static let distanceBetweenLabels: CGFloat = 3
    }
    
    // MARK: - Properties
    
    private var wordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Locals.numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextMedium(ofSize: Locals.wordLabelSize)
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
        label.numberOfLines = Locals.numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextRegular(ofSize: Locals.translationLabelSize)
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.containerViewLeadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.containerViewTrailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Locals.containerViewTopAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.containerViewBottomAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.labelLeadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.labelTrailingAnchor),
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor),
            translationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.labelLeadingAnchor),
            translationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.labelTrailingAnchor),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            translationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.labelBottomAnchor)
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
