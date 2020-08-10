//
//  WordSetLearnCollectionViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class WordSetLearnCollectionViewCell: UICollectionViewCell {
    
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
        wordLabel.font = .boldSystemFont(ofSize: 28)
        wordLabel.textColor = .black
        
        wordLabel.numberOfLines = 0
        wordLabel.lineBreakMode = .byWordWrapping
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        wordLabel.sizeToFit()
        
        addSubview(inputTextField)
        inputTextField.layer.cornerRadius = 5
        inputTextField.layer.borderWidth = 3
        inputTextField.layer.borderColor = UIColor.white.cgColor
        inputTextField.placeholder = "Type translation here"
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        inputTextField.autocorrectionType = .no
        inputTextField.becomeFirstResponder()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            inputTextField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10)
        ])
        
        addSubview(lineView)
        lineView.backgroundColor = UIColor.blueSapphire
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 5),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
        
        addSubview(resultExerciseLabel)
        resultExerciseLabel.numberOfLines = 0
        resultExerciseLabel.lineBreakMode = .byWordWrapping
        resultExerciseLabel.font = .boldSystemFont(ofSize: 24)
        resultExerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultExerciseLabel.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 5),
            resultExerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultExerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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
