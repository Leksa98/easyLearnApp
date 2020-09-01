//
//  WordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let leadingAnchor: CGFloat = 25
        static let trailingAnchor: CGFloat = -25
        static let bottomAnchor: CGFloat = -100
        static let stackSpacing: CGFloat = 30
    }
    
    // MARK: - Properties
    
    private let listButton = ButtonWithRoundCorners(title: NSLocalizedString("word_set_list", comment: ""))
    private let cardsButton = ButtonWithRoundCorners(title: NSLocalizedString("word_set_cards", comment: ""))
    private let learnButton = ButtonWithRoundCorners(title: NSLocalizedString("word_set_learn", comment: ""))
    private let statisticsButton = ButtonWithRoundCorners(title: NSLocalizedString("word_set_statistics", comment: ""))
    private let stackButton = UIStackView()
    var router: WordSetRouterLogic?
    var setName: String? {
        didSet {
            title = setName
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        setButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
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
        stackButton.spacing = Locals.stackSpacing
        view.addSubview(stackButton)
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                stackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Locals.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                stackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Locals.bottomAnchor)
            ])
        }
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
