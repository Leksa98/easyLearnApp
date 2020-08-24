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
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let topAnchor: CGFloat = -20
        
        static let messageLabelSize: CGFloat = 20
        static let numberOfLines = 0
    }
    
    // MARK: - Property
    
    private var messageLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageLabel.text = "You haven't added any words yet. All your added words will show up here."
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = Locals.numberOfLines
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.sfProTextMedium(ofSize: Locals.messageLabelSize)
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: Locals.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
