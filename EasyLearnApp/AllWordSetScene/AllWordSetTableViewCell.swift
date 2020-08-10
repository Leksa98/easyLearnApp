//
//  WordSetTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class AllWordSetTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var setTitle: UILabel! = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var progressBar: UIProgressView! = {
        let progress = UIProgressView()
        progress.transform = progress.transform.scaledBy(x: 1, y: 6)
        progress.layer.cornerRadius = 10
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 10
        progress.subviews[1].clipsToBounds = true
        return progress
    }()
    
    private var emojiLabel: UILabel! = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45)
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
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            emojiLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            setTitle.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 10),
            setTitle.centerYAnchor.constraint(equalTo: emojiLabel.centerYAnchor),
            setTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            setTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            progressBar.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 20),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
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
