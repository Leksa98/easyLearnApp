//
//  WordSetCardCollectionViewCell.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class WordSetCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Locals {
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cornerRadius = CGFloat(40)
    }
    
    // MARK: - Property
    
    private var frontView = WordSetCardView()
    private var backView = WordSetCardView()
    
    private var frontText: String?
    private var backText: String?
    
    private var isFrontText = true
    
    var viewModel: WordModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(wordModel: viewModel)
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView(view: frontView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func setView(view: WordSetCardView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Public
    
    func updateContent(wordModel: WordModel) {
        frontText = wordModel.word
        backText = wordModel.translation
        if let frontText = frontText, let backText = backText {
            frontView.setTextLabel(text: frontText)
            backView.setTextLabel(text: backText)
        }
    }
    
    func flipCardAnimation() {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
            
            switch self.isFrontText {
            case true:
                self.frontView.removeFromSuperview()
                self.setView(view: self.backView)
                self.isFrontText = false
            case false:
                self.backView.removeFromSuperview()
                self.setView(view: self.frontView)
                self.isFrontText = true
            }
            
            }, completion: nil)
    }
    
}
