//
//  AddWordTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 16.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddWordTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowColor = UIColor.orange.cgColor
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.backgroundColor = UIColor(cgColor: CGColor(srgbRed:0.53, green: 0.85, blue: 0.75, alpha: 1))
        return containerView
    }()
    
    var viewModel: String? {
        didSet {
            if let viewModel = viewModel {
                updateContent(label: viewModel)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.83, green: 1, blue: 0.96, alpha: 1))
        addSubview(containerView)
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.6, green: 0.96, blue: 0.85, alpha: 1))
        selectedBackgroundView = bgColorView
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
        ])
    }
    
    func updateContent(label: String) {
        titleLabel.text = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
