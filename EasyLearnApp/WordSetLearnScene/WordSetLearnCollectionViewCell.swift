//
//  WordSetLearnCollectionViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class WordSetLearnCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let questionViewColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cornerRadius = CGFloat(40)
        static let answerViewColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        static let borderColor = UIColor(cgColor: CGColor(srgbRed: 84.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 1)).cgColor
        static let textFieldColor = UIColor(cgColor: CGColor(srgbRed: 196.0/255.0, green: 198.0/255.0, blue: 212.0/255.0, alpha: 1))
        static let placeholderColor = UIColor(cgColor: CGColor(srgbRed: 112.0/255.0, green: 99.0/255.0, blue: 134.0/255.0, alpha: 1))
    }
    
    private var wordLabel = UILabel()
    private var lineView = UIView()
    private var inputTextField = UITextField()
    
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(value: viewModel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Locals.backgroundColor
        addSubview(wordLabel)
        //wordLabel.text = "Word"
        wordLabel.font = .boldSystemFont(ofSize: 40)
        wordLabel.textColor = .black
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            wordLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(inputTextField)
        inputTextField.placeholder = "Type translation here"
        inputTextField.becomeFirstResponder()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            inputTextField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10)
        ])
        
        addSubview(lineView)
        lineView.backgroundColor = UIColor(cgColor: Locals.borderColor)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(value: WordModel) {
        wordLabel.text = value.word
    }
}
