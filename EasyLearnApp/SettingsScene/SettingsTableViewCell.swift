//
//  SettingsTableViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum Locals {
        static let lebelSize: CGFloat = 20
        static let leadingAnchor: CGFloat = 20
        static let trailingAnchor: CGFloat = -20
        static let topAnchor: CGFloat = 10
        static let bottomAnchor: CGFloat = -10
    }
    
    // MARK: - Properties
    
    private var label = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        addSubview(label)
        label.text = "Learning language"
        label.font = UIFont.sfProTextMedium(ofSize: Locals.lebelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Locals.topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
