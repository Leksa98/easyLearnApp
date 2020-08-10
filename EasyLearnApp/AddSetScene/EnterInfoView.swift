//
//  EnterInfoView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class EnterInfoView: UIView {
    
    // MARK: - Properties
    
    private var infoLabel: UILabel!
    private var enterInfoTextField: UITextField!
    
    public var enteredInfo: String? {
        get {
            return enterInfoTextField.text
        }
    }
    
    // MARK: - Initialization
    
    init(label: String, textField: String) {
        super.init(frame: .zero)
        configureView()
        configureInfoLabel(label: label)
        configureInfoTextField(textField: textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configureView() {
        backgroundColor = UIColor.customLightBlue
        layer.borderWidth = 2
        layer.borderColor = UIColor.customDarkPurple.cgColor
        layer.cornerRadius = 15
    }
    
    private func configureInfoLabel(label: String) {
        infoLabel = UILabel()
        addSubview(infoLabel)
        infoLabel.text = label
        infoLabel.font = .boldSystemFont(ofSize: 20)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
    
    private func configureInfoTextField(textField: String) {
        enterInfoTextField = UITextField()
        addSubview(enterInfoTextField)
        enterInfoTextField.attributedPlaceholder = NSAttributedString(string: textField, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor, NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 18)])
        enterInfoTextField.font = .systemFont(ofSize: 18)
        enterInfoTextField.backgroundColor = UIColor.textFieldColor
        enterInfoTextField.textColor = .black
        enterInfoTextField.layer.cornerRadius = 6.0
        enterInfoTextField.layer.masksToBounds = true
        enterInfoTextField.borderStyle = .roundedRect
        enterInfoTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             enterInfoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
             enterInfoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
             enterInfoTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
             enterInfoTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    public func emptyEnteredInfo() {
        enterInfoTextField.text = nil
    }
}
