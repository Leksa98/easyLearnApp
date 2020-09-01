//
//  NewWordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class NewWordSetViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let stackSpacing: CGFloat = 40
        static let leadingAnchor: CGFloat = 20
        static let trailingAnchor: CGFloat = -20
    }
    
    // MARK: - Properties
    
    private let defaultSetButton = ButtonWithRoundCorners(title: NSLocalizedString("new_word_set_view_default_sets", comment: ""))
    private let addNewSetButton = ButtonWithRoundCorners(title: NSLocalizedString("new_word_set_add_new_set", comment: ""))
    private let buttonStackView = UIStackView()
    var router: NewWordSetRouterLogic?
    
     // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.blueSapphire
        navigationItem.title = NSLocalizedString("new_word_set_title", comment: "")
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(defaultSetButton)
        buttonStackView.addArrangedSubview(addNewSetButton)
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = Locals.stackSpacing
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        defaultSetButton.translatesAutoresizingMaskIntoConstraints = false
        addNewSetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
        ])
        
        addNewSetButton.addTarget(self, action: #selector(addNewSetButtonTapped), for: .touchUpInside)
        defaultSetButton.addTarget(self, action: #selector(defaultSetButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Button actions
    
    @objc private func addNewSetButtonTapped() {
        router?.routeToAddSetScene()
    }
    
    @objc private func defaultSetButtonTapped() {
        router?.routeToDefaultWordSetScene()
    }
}
