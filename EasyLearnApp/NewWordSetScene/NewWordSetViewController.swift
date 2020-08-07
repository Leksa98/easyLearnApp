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
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let navigationBarColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
    }
    
    // MARK: - Properties
    
    private let defaultSetButton = ButtonWithRoundCorners(title: "View default sets")
    private let addNewSetButton = ButtonWithRoundCorners(title: "Add new set")
    private let buttonStackView = UIStackView()
    
     // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Locals.backgroundColor
        navigationController?.navigationBar.tintColor = Locals.navigationBarColor
        title = "Add word set"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(defaultSetButton)
        buttonStackView.addArrangedSubview(addNewSetButton)
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 40
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        defaultSetButton.translatesAutoresizingMaskIntoConstraints = false
        addNewSetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        addNewSetButton.addTarget(self, action: #selector(addNewSetButtonTapped), for: .touchUpInside)
        defaultSetButton.addTarget(self, action: #selector(defaultSetButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Button actions
    
    @objc private func addNewSetButtonTapped() {
        navigationController?.pushViewController(AddSetViewController(), animated: false)
    }
    
    @objc private func defaultSetButtonTapped() {
        navigationController?.pushViewController(DefaultWordSetConfigurator.assembly(), animated: false)
    }
}
