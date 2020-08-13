//
//  EnterInfoView.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class EnterInfoView: UIView {
    
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
        infoLabel.font = UIFont.sfProTextHeavy(ofSize: 20)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
    }
    
    private func configureInfoTextField(textField: String) {
        addSubview(enterInfoTextField)
        enterInfoTextField.attributedPlaceholder = NSAttributedString(string: textField, attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueSapphire, NSAttributedString.Key.font: UIFont.sfProTextRegular(ofSize: 18) ?? UIFont.systemFont(ofSize: 18)])
        enterInfoTextField.backgroundColor = UIColor.lightCyan
        enterInfoTextField.textColor = .blueSapphire
        enterInfoTextField.font = UIFont.sfProTextMedium(ofSize: 18)
        enterInfoTextField.borderStyle = .roundedRect
        enterInfoTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
             enterInfoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
             enterInfoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
             enterInfoTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
             enterInfoTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func configureLineView() {
        addSubview(lineView)
        lineView.backgroundColor = .lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.7)
        ])
    }
    
    public func emptyEnteredInfo() {
        enterInfoTextField.text = nil
    }
}
