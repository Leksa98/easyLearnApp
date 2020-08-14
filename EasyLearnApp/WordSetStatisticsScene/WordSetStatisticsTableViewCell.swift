//
//  WordSetStatisticsTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 12.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetStatisticsTableViewCell: UITableViewCell {

    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 6
        static let wordLabelSize: CGFloat = 18
        static let translationLabelSize: CGFloat = 16
        static let progressLabelSize: CGFloat = 14
        static let labelNumberOfLines: Int = 0
        
        static let containerViewLeadingAnchor: CGFloat = 10
        static let containerViewTrailingAnchor: CGFloat = -10
        static let containerViewTopAnchor: CGFloat = 10
        static let containerViewBottomAnchor: CGFloat = -10
        
        static let labelLeadingAnchor: CGFloat = 20
        static let labelTrailingAnchor: CGFloat = -20
        static let labelTopAnchor: CGFloat = 20
        static let labelBottomAnchor: CGFloat = -20
        static let distanceBetweenLabels: CGFloat = 3
    }
    
    // MARK: - Properties
    
    private var wordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Locals.labelNumberOfLines
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
        label.numberOfLines = Locals.labelNumberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextRegular(ofSize: Locals.translationLabelSize)
        label.textColor = .blueSapphire
        return label
    }()
    
    private var correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfProTextRegular(ofSize: Locals.progressLabelSize)
        label.textColor = .customGreen
        return label
    }()
    
    private var wrongAnswerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfProTextRegular(ofSize: Locals.progressLabelSize)
        label.textColor = .customRed
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
        containerView.addSubview(correctAnswerLabel)
        containerView.addSubview(wrongAnswerLabel)
        containerView.layer.masksToBounds = true
        let bgColorView = UIView()
        bgColorView.layer.cornerRadius = Locals.cornerRadius
        bgColorView.backgroundColor = UIColor.persianGreen
        selectedBackgroundView = bgColorView
        
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.containerViewLeadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.containerViewTrailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Locals.containerViewTopAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.containerViewBottomAnchor),
            
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.labelLeadingAnchor),
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor),
            correctAnswerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor),
            correctAnswerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.labelTrailingAnchor),
            wordLabel.trailingAnchor.constraint(lessThanOrEqualTo: correctAnswerLabel.leadingAnchor, constant: Locals.labelTrailingAnchor),
            
            translationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.labelLeadingAnchor),
            translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            translationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.labelBottomAnchor),
            wrongAnswerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.labelBottomAnchor),
            wrongAnswerLabel.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            wrongAnswerLabel.leadingAnchor.constraint(equalTo: correctAnswerLabel.leadingAnchor),
            wrongAnswerLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: Locals.labelTrailingAnchor),
            translationLabel.trailingAnchor.constraint(lessThanOrEqualTo: wrongAnswerLabel.leadingAnchor, constant: Locals.labelTrailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(viewModel: WordModel) {
        wordLabel.text = viewModel.word.capitalizingFirstLetter()
        translationLabel.text = viewModel.translation.capitalizingFirstLetter()
        correctAnswerLabel.text = "Correct answers: \(viewModel.rightAnswer)"
        wrongAnswerLabel.text = "Wrong answers: \(viewModel.wrongAnswer)"
    }
}
