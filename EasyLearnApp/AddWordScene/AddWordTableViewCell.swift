//
//  AddWordTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 16.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddWordTableViewCell: UITableViewCell {
   
    // MARK: - Constants
    
    private enum Locals {
        static let cornerRadius: CGFloat = 6
        
        static let numberOfLines = 0
        static let labelSize: CGFloat = 18
        
        static let containerViewLeadingAnchor: CGFloat = 10
        static let containerViewTrailingAnchor: CGFloat = -10
        static let containerViewTopAnchor: CGFloat = 10
        static let containerViewBottomAnchor: CGFloat = -10
        
        static let labelLeadingAnchor: CGFloat = 20
        static let labelTrailingAnchor: CGFloat = -20
        static let labelBottomAnchor: CGFloat = -20
        static let labelTopAnchor: CGFloat = 20
    }
    
    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Locals.numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextMedium(ofSize: Locals.labelSize)
        label.textColor = .blueSapphire
        return label
    }()
    
    var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = Locals.cornerRadius
        containerView.backgroundColor = UIColor.lightCyan
        return containerView
    }()
    
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(label: viewModel.translation)
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(containerView)
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let bgColorView = UIView()
        bgColorView.layer.cornerRadius = Locals.cornerRadius
        bgColorView.backgroundColor = UIColor.persianGreen
        selectedBackgroundView = bgColorView
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.containerViewLeadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.containerViewTrailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Locals.containerViewTopAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.containerViewBottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.labelLeadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.labelTrailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.labelBottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update content
    
    private func updateContent(label: String) {
        titleLabel.text = label
    }
}
