//
//  WordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let listButton = ButtonWithRoundCorners(title: "List")
    private let cardsButton = ButtonWithRoundCorners(title: "Cards")
    private let learnButton = ButtonWithRoundCorners(title: "Learn")
    private let statisticsButton = ButtonWithRoundCorners(title: "Statistics")
    private let stackButton = UIStackView()
    var router: WordSetRouterLogic?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor.backgroundColor
        setButtons()
    }
    
    // MARK: - Setup UI elements
    
    private func setButtons() {
        stackButton.addArrangedSubview(listButton)
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        stackButton.addArrangedSubview(cardsButton)
        cardsButton.addTarget(self, action: #selector(cardsButtonTapped), for: .touchUpInside)
        stackButton.addArrangedSubview(learnButton)
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        stackButton.addArrangedSubview(statisticsButton)
        statisticsButton.addTarget(self, action: #selector(statisticsButtonTapped), for: .touchUpInside)
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
    
    // MARK: - Button actions
    
    @objc private func listButtonTapped() {
       if let title = title {
            router?.routeToWordSetList(with: title)
        }
    }
    
    @objc private func cardsButtonTapped() {
        if let title = title {
            router?.routeToWordSetCards(with: title)
        }
    }
    
    @objc private func learnButtonTapped() {
        if let title = title {
            router?.routeToWordSetLearn(with: title)
        }
    }
    
    @objc private func statisticsButtonTapped() {
        if let title = title {
            router?.routeToWordSetStatistics(with: title)
        }
    }
}
