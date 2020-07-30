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
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
    }
    
    // MARK: - Properties
    
    private let listButton = ButtonWithRoundCorners(title: "List")
    private let cardsButton = ButtonWithRoundCorners(title: "Cards")
    private let learnButton = ButtonWithRoundCorners(title: "Learn")
    private let statisticsButton = ButtonWithRoundCorners(title: "Statistics")
    private let stackButton = UIStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Locals.backgroundColor
        setButtons()
    }
    
    // MARK: - Configurations
    
    private func setButtons() {
        stackButton.addArrangedSubview(listButton)
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        stackButton.addArrangedSubview(cardsButton)
        cardsButton.addTarget(self, action: #selector(cardsButtonTapped), for: .touchUpInside)
        stackButton.addArrangedSubview(learnButton)
        stackButton.addArrangedSubview(statisticsButton)
        stackButton.axis = .vertical
        stackButton.distribution = .fillEqually
        stackButton.alignment = .fill
        stackButton.spacing = 30
        view.addSubview(stackButton)
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            stackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc private func listButtonTapped() {
        let delegete: WordListTablePresentationLogic?
        delegete = WordListTableViewController()
        navigationController?.pushViewController(delegete as! UIViewController, animated: false)
        delegete?.showWordList(setName: title!)
    }
    
    @objc private func cardsButtonTapped() {
        let delegete: WordSetCardsShow?
        delegete = WordSetCardsViewController()
        navigationController?.pushViewController(delegete as! UIViewController, animated: false)
        if let title = title {
            delegete?.loadSetName(name: title)
        }
    }
}


// MARK: - WordSetPresentationLogic
extension WordSetViewController: WordSetPresentationLogic {
    
    func presentWordSet(wordSet: WordSetModel) {
        self.title = wordSet.nameValue
    }
}
