//
//  ChooseLanguageTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ChooseLanguageTableViewCell: UITableViewCell {
    
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
        languageLabel.font = UIFont.sfProTextMedium(ofSize: 20)
        flagLabel.font = .systemFont(ofSize: 30)
        addSubview(languageLabel)
        addSubview(flagLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            flagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            languageLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 10),
            languageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            languageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateContent(viewModel: LanguageModel) {
        languageLabel.text = viewModel.languageValue
        flagLabel.text = viewModel.flagValue
    }
}
