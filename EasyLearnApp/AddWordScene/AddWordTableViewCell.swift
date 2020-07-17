//
//  AddWordTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 16.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddWordTableViewCell: UITableViewCell {
    /*
     "TimesNewRomanPS-ItalicMT"
     - "TimesNewRomanPS-BoldItalicMT"
     - "TimesNewRomanPS-BoldMT"
     - "TimesNewRomanPSMT"
     */
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 181.0/255.0, green: 166.0/255.0, blue: 201.0/255.0, alpha: 1))
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
        backgroundColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        addSubview(containerView)
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let bgColorView = UIView()
        bgColorView.layer.cornerRadius = 15
        bgColorView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 202.0/255.0, green: 192.0/255.0, blue: 216.0/255.0, alpha: 1))
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
