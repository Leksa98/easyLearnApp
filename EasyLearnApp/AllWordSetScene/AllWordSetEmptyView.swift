//
//  AllWordSetEmptyView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AllWordSetEmptyView: UIView {
    
    // MARK: - Constants
    
    private enum Locals {
        static let titleLabelSize: CGFloat = 24
        static let messageLabelSize: CGFloat = 20
        
        static let numberOfLines = 0
        
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = 100
        static let imageBottomAnchor: CGFloat = -10
        
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let topAnchor: CGFloat = 10
    }
    
    // MARK: - Property
    
    private var titleLabel = UILabel()
    private var messageLabel = UILabel()
    private var image = UIImageView()
    private var button = ButtonWithRoundCorners(title: "Add set")
    var tabBarController: UITabBarController?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "Sets"
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.sfProTextMedium(ofSize: Locals.titleLabelSize)
        
        messageLabel.text = "You don't have any sets yet. All your sets will show up here."
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = Locals.numberOfLines
        messageLabel.font = UIFont.sfProTextMedium(ofSize: Locals.messageLabelSize)
        messageLabel.textAlignment = .center
        
        image.image = UIImage(named: "Study-gray")
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(image)
        addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Locals.topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Locals.imageBottomAnchor),
            image.widthAnchor.constraint(equalToConstant: Locals.imageWidth),
            image.heightAnchor.constraint(equalToConstant: Locals.imageHeight),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Locals.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        tabBarController?.selectedIndex = 1
    }
    
}
