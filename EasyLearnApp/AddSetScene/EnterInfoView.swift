//
//  EnterInfoView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class EnterInfoView: UIView {
    
    // MARK: - Constants
    enum Locals {
        static let labelTextSize: CGFloat = 18
        static let textFieldSize: CGFloat = 16
        
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        
        static let labelTopAnchor: CGFloat = 15
        static let textFieldTopAnchor: CGFloat = 10
        static let textFieldBottomAnchor: CGFloat = -15
        static let lineViewHeightAnchor: CGFloat = 0.7
    }
    
    // MARK: - Properties
    
    private var infoLabel = UILabel()
    private var enterInfoTextField = UITextField()
    private var lineView = UIView()
    
    public var enteredInfo: String? {
        get {
            return enterInfoTextField.text
        }
    }
    
    // MARK: - Initialization
    
    init(label: String, textField: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        configureInfoLabel(label: label)
        configureInfoTextField(textField: textField)
        configureLineView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureInfoLabel(label: String) {
        addSubview(infoLabel)
        infoLabel.text = label
        infoLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.labelTextSize)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor)
        ])
    }
    
    private func configureInfoTextField(textField: String) {
        addSubview(enterInfoTextField)
        enterInfoTextField.attributedPlaceholder = NSAttributedString(string: textField, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueSapphire, NSAttributedString.Key.font: UIFont.sfProTextRegular(ofSize: Locals.textFieldSize) ?? UIFont.systemFont(ofSize: Locals.textFieldSize)])
        enterInfoTextField.backgroundColor = UIColor.lightCyan
        enterInfoTextField.textColor = .blueSapphire
        enterInfoTextField.font = UIFont.sfProTextMedium(ofSize: Locals.textFieldSize)
        enterInfoTextField.borderStyle = .roundedRect
        enterInfoTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             enterInfoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
             enterInfoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
             enterInfoTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: Locals.textFieldTopAnchor),
             enterInfoTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.textFieldBottomAnchor)
        ])
    }
    
    private func configureLineView() {
        addSubview(lineView)
        lineView.backgroundColor = .lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Locals.lineViewHeightAnchor)
        ])
    }
    
    public func emptyEnteredInfo() {
        enterInfoTextField.text = nil
    }
}
