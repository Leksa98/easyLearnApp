//
//  AddSetTableEmptyView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetTableEmptyView: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let titleLabelSize: CGFloat = 24
        static let messageLabelSize: CGFloat = 20
        
        static let numberOfLines = 0
        
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let topAnchor: CGFloat = 10
        static let centerYAnchor: CGFloat = -30
    }
    
    // MARK: - Property
    
    private var titleLabel = UILabel()
    private var messageLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "Words"
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.sfProTextMedium(ofSize: Locals.titleLabelSize)
        
        messageLabel.text = "You haven't added any words yet. All your added words will show up here."
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = Locals.numberOfLines
        messageLabel.font = UIFont.sfProTextMedium(ofSize: Locals.messageLabelSize)
        messageLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(messageLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Locals.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Locals.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
