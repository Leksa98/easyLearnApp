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
        static let cornerRadius = CGFloat(6)
    }
    
    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.sfProTextMedium(ofSize: 18)
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
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
