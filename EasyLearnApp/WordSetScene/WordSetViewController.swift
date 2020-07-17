//
//  WordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit


protocol WordSetPresentationLogic {
    func presentWordSet(wordSet: WordSetModel)
}


final class WordSetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let listButton = ButtonWithRoundCorners(title: "List")
    private let cardsButton = ButtonWithRoundCorners(title: "Cards")
    private let learnButton = ButtonWithRoundCorners(title: "Learn")
    private let statisticsButton = ButtonWithRoundCorners(title: "Statistics")
    private let stackButton = UIStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setButtons()
    }
    
    // MARK: - Configurations
    
    private func setButtons() {
        stackButton.addArrangedSubview(listButton)
        stackButton.addArrangedSubview(cardsButton)
        stackButton.addArrangedSubview(learnButton)
        stackButton.addArrangedSubview(statisticsButton)
        stackButton.axis = .vertical
        stackButton.distribution = .fillEqually
        stackButton.alignment = .fill
        stackButton.spacing = 40
        view.addSubview(stackButton)
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            stackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
}


// MARK: - WordSetPresentationLogic
extension WordSetViewController: WordSetPresentationLogic {
    
    func presentWordSet(wordSet: WordSetModel) {
        self.title = wordSet.nameValue
    }
}


final class ButtonWithRoundCorners: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = .systemBlue
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
