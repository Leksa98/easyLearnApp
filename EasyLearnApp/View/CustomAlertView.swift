//
//  CustomAlertView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 20.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class CustomAlertView: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let titleSize: CGFloat = 20
        static let messageSize: CGFloat = 18
        static let messageNumberOfLines = 0
        
        static let titleTopAnchor: CGFloat = 20
        static let titleTrailingAnchor: CGFloat = -40
        static let leadingAnchor: CGFloat = 30
        static let trailingAnchor: CGFloat = -30
        static let distanceBetweenElements: CGFloat = 5
        static let buttonBottomAnchor: CGFloat = -20
        static let buttonWidthAnchor: CGFloat = 50
    }
    
    // MARK: - Property
    
    private let imageView = UIImageView()
    var titleLabel = UILabel()
    var messageLabel = UILabel()
    let button = ButtonWithRoundCorners(title: "OK")
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(button)
        
        imageView.image = UIImage(named: "alert")
        titleLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.titleSize)
        messageLabel.font = UIFont.sfProTextMedium(ofSize: Locals.messageSize)
        messageLabel.numberOfLines = Locals.messageNumberOfLines
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor, constant: Locals.titleTopAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Locals.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Locals.titleTrailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Locals.distanceBetweenElements),
            messageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Locals.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Locals.trailingAnchor),
            
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Locals.distanceBetweenElements),
            button.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor, constant: Locals.buttonBottomAnchor),
            button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Locals.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: Locals.buttonWidthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
