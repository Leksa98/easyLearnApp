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
        backgroundColor = UIColor.white
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
        enterInfoTextField.attributedPlaceholder = NSAttributedString(string: textField, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueSapphire, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        enterInfoTextField.backgroundColor = UIColor.lightCyan
        enterInfoTextField.textColor = .blueSapphire
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
