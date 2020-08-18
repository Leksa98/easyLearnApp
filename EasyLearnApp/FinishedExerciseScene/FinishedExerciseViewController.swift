//
//  FinishedExerciseViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 17.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class FinishedExerciseViewController: UIViewController {

    // MARK: - Constants
    
    enum Locals {
        static let numberOfLines = 0
        static let topAnchor: CGFloat = 100
        static let labelSize: CGFloat = 25
        static let stackSpacing: CGFloat = 40
        static let leadingAnchor: CGFloat = 20
        static let trailingAnchor: CGFloat = -20
    }
    
    // MARK: - Properties
    
    private var learnAgainButton = ButtonWithRoundCorners(title: "Practice again")
    private var finishButton = ButtonWithRoundCorners(title: "Finish practice")
    private let buttonStackView = UIStackView()
    private var label = UILabel()
    var router: FinishedExerciseRouterLogic?
    var setTitle: String?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        setUpLabel()
        setUpButtons()
    }
    
    // MARK: - Setup UI elements
    
    private func setUpLabel() {
        view.addSubview(label)
        label.numberOfLines = Locals.numberOfLines
        label.text = "Congratulations 🎉🎉🎉\n" + "You've just finished exercise!"
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.sfProTextHeavy(ofSize: Locals.labelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.topAnchor),
                label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Locals.topAnchor),
                label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    private func setUpButtons() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(learnAgainButton)
        buttonStackView.addArrangedSubview(finishButton)
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = Locals.stackSpacing
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        learnAgainButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
        ])
        
        learnAgainButton.addTarget(self, action: #selector(addNewSetButtonTapped), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Buttons actions
    
    @objc private func finishButtonTapped() {
        router?.routeBack()
    }
    
    @objc private func addNewSetButtonTapped() {
        if let setTitle = setTitle {
            router?.learnAgain(with: setTitle)
        }
    }
}
