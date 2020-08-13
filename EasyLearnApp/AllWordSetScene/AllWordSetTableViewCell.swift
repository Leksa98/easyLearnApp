//
//  WordSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class AllWordSetTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    enum Locals {
        static let cornerRadius: CGFloat = 10
        static let titleSize: CGFloat = 20
        static let emojiSize: CGFloat = 45
        static let leadingAnchor: CGFloat = 25
        static let topAnchor: CGFloat = 10
        static let progressBarTopAnchor: CGFloat = 20
        static let progressBarBottomAnchor: CGFloat = -20
        static let progressTrailingAnchor: CGFloat = -70
        static let titleLeadingAnchor: CGFloat = 10
        static let titleTrailingAnchor: CGFloat = -25
    }
    
    // MARK: - Properties
    
    private var setTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfProTextHeavy(ofSize: Locals.titleSize)
        return label
    }()
    
    private var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.transform = progress.transform.scaledBy(x: 1, y: 6)
        progress.layer.cornerRadius = Locals.cornerRadius
        progress.clipsToBounds = true
        progress.layer.sublayers?.forEach { sublayer in
            sublayer.cornerRadius = Locals.cornerRadius
        }
        progress.subviews.forEach { subview in
            subview.clipsToBounds = true
        }
        return progress
    }()
    
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Locals.emojiSize)
        return label
    }()
    
    var viewModel: WordSetModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        backgroundColor = .white
        addSubview(setTitle)
        addSubview(progressBar)
        addSubview(emojiLabel)
        setTitle.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            emojiLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.topAnchor),
            setTitle.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: Locals.titleLeadingAnchor),
            setTitle.centerYAnchor.constraint(equalTo: emojiLabel.centerYAnchor),
            setTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.titleTrailingAnchor),
            setTitle.topAnchor.constraint(equalTo: topAnchor, constant: Locals.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.progressTrailingAnchor),
            progressBar.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: Locals.progressBarTopAnchor),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.progressBarBottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func hideProgressBar() {
        progressBar.isHidden = true
    }
    
    // MARK: - Private
    
    private func updateContent(with viewModel: WordSetModel) {
        setTitle.text = viewModel.nameValue
        emojiLabel.text = viewModel.emojiValue
        progressBar.progress = viewModel.progressValue
        switch viewModel.progressValue {
        case 0..<0.25:
            progressBar.tintColor = .red
        case 0.25..<0.5:
            progressBar.tintColor = .orange
        case 0..<0.75:
            progressBar.tintColor = .yellow
        default:
            progressBar.tintColor = .green
        }
    }
}
