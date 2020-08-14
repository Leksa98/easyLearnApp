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
    
    enum Locals {
        static let labelSize: CGFloat = 30
        static let labelNumberOfLines = 0
        static let textFieldCornerRadius: CGFloat = 5
        static let textFieldBorderWidth: CGFloat = 3
        static let textFieldSize: CGFloat = 20
        static let resultLabelSize: CGFloat = 25
        
        static let paddingViewHeight: CGFloat = 20
        static let paddingViewWidth: CGFloat = 10
        
        static let labelTopAnchor: CGFloat = 10
        static let leadingAnchor: CGFloat = 20
        static let trailingAnchor: CGFloat = -20
        static let textFieldHeight: CGFloat = 40
        static let lineViewHeight: CGFloat = 2
        static let lineViewTopAnchor: CGFloat = 5
        static let lineViewBottomAnchor: CGFloat = -40
    }
    
    // MARK: - Properties
    
    private var wordLabel = UILabel()
    private var lineView = UIView()
    private var inputTextField = UITextField()
    private var resultExerciseLabel = UILabel()
    
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(value: viewModel)
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(wordLabel)
        wordLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.labelSize)
        wordLabel.textColor = .black

        wordLabel.numberOfLines = Locals.labelNumberOfLines
        wordLabel.lineBreakMode = .byWordWrapping
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: Locals.labelTopAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
        ])
        wordLabel.sizeToFit()
        
        addSubview(inputTextField)
        inputTextField.layer.cornerRadius = Locals.textFieldCornerRadius
        inputTextField.layer.borderWidth = Locals.textFieldBorderWidth
        inputTextField.layer.borderColor = UIColor.white.cgColor
        inputTextField.placeholder = "Type translation here"
        inputTextField.font = UIFont.sfProTextMedium(ofSize: Locals.textFieldSize)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Locals.paddingViewWidth, height: Locals.paddingViewHeight))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        inputTextField.autocorrectionType = .no
        inputTextField.becomeFirstResponder()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.heightAnchor.constraint(equalToConstant: Locals.textFieldHeight),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            inputTextField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: Locals.labelTopAnchor)
        ])
        
        addSubview(lineView)
        lineView.backgroundColor = UIColor.blueSapphire
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: Locals.lineViewHeight),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: Locals.lineViewTopAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Locals.lineViewBottomAnchor)
        ])
        
        addSubview(resultExerciseLabel)
        resultExerciseLabel.numberOfLines = Locals.labelNumberOfLines
        resultExerciseLabel.lineBreakMode = .byWordWrapping
        resultExerciseLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.resultLabelSize)
        resultExerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultExerciseLabel.topAnchor.constraint(equalTo: lineView.topAnchor, constant: Locals.lineViewTopAnchor),
            resultExerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Locals.leadingAnchor),
            resultExerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Locals.trailingAnchor),
        ])
        resultExerciseLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        inputTextField.text = ""
        inputTextField.layer.borderColor = UIColor.white.cgColor
        resultExerciseLabel.text = ""
    }
    
    // MARK: - Public
    
    func updateContent(value: WordModel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.hyphenationFactor = 1.0
        let attributedTitle =  NSAttributedString(string: value.word.capitalizingFirstLetter(), attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        wordLabel.attributedText = attributedTitle
    }
    
    func checkExercise() -> Bool {
        guard let userInputTextField = inputTextField.text, let viewModel = viewModel else {
            return false
        }
        if userInputTextField.trimmingCharacters(in: .whitespacesAndNewlines).capitalized == viewModel.translation.capitalized {
            return true
        }
        return false
    }
    
    func showAnimation(correctAnswer: Bool, completion: ((Bool) -> Void)? = nil) {
        var borderColor: CGColor
        var textForResultExerciseLabel: String
        switch correctAnswer {
        case true:
            borderColor = UIColor.customGreen.cgColor
            resultExerciseLabel.textColor = UIColor.customGreen
            textForResultExerciseLabel = "Correct"
        case false:
            borderColor = UIColor.customRed.cgColor
            resultExerciseLabel.textColor = UIColor.customRed
            textForResultExerciseLabel = "Wrong"
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.inputTextField.layer.borderColor = borderColor
        }) { finished in
            UIView.transition(with: self.resultExerciseLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {[weak self] in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                paragraphStyle.hyphenationFactor = 1.0
                let attributedTitle =  NSAttributedString(string: textForResultExerciseLabel, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
                self?.resultExerciseLabel.attributedText = attributedTitle
            }) { finished in
                if let completion = completion {
                    completion(finished)
                }
            }
        }
    }
    
    func showHelpAnimation() {
        UIView.transition(with: resultExerciseLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {[weak self] in
            if let translation = self?.viewModel?.translation {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                paragraphStyle.hyphenationFactor = 1.0
                self?.resultExerciseLabel.textColor = UIColor.customRed
                let attributedTitle =  NSAttributedString(string: translation.capitalizingFirstLetter(), attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
                self?.resultExerciseLabel.attributedText = attributedTitle
            }
            }, completion: nil)
    }
    
    func isWrongWordTyped() -> Bool {
        if resultExerciseLabel.text == "Wrong" ||  resultExerciseLabel.text == viewModel?.translation {
            return true
        }
        return false
    }
}
