//
//  AboutAppViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 25.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AboutAppDisplayLogic: class {
    func updateDescription(viewModel: AboutAppModel.AppDescription.ViewModel)
}

final class AboutAppViewController: UIViewController {

    // MARK: - Constants
    
    private enum Locals {
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let topAnchor: CGFloat = 15
        
        static let descriptionSize: CGFloat = 18
        static let numberOfLines = 0
        static let cornerRadius: CGFloat = 9
        static let imageSideSize: CGFloat = 60
    }
    
    // MARK: - Property
    
    private var descriptionLabel = UILabel()
    private var appImageView = UIImageView()
    private var appNameLabel = UILabel()
    var interactor: AboutAppBusinessLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("settings_about_app_section", comment: "")
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        tabBarController?.tabBar.isHidden = true
        setupImage()
        setupLabel()
        interactor?.fetchDescription(request: AboutAppModel.AppDescription.Request())
    }
    
    // MARK: - Setup UI elements
    
    private func setupImage() {
        appImageView.image = UIImage(named: "Icon")
        appImageView.layer.cornerRadius = Locals.cornerRadius
        appImageView.layer.masksToBounds = true
        view.addSubview(appImageView)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            appImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.topAnchor).isActive = true
        } else {
            appImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Locals.topAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            appImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            appImageView.heightAnchor.constraint(equalToConstant: Locals.imageSideSize),
            appImageView.widthAnchor.constraint(equalToConstant: Locals.imageSideSize),
        ])
    }
    
    private func setupLabel() {
        view.addSubview(descriptionLabel)
        view.addSubview(appNameLabel)
        descriptionLabel.font = UIFont.sfProTextMedium(ofSize: Locals.descriptionSize)
        appNameLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.descriptionSize)
        appNameLabel.textColor = .black
        appNameLabel.text = NSLocalizedString("EasyLearnApp", comment: "")
        descriptionLabel.textColor = .customDarkGray
        descriptionLabel.numberOfLines = Locals.numberOfLines
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appNameLabel.centerYAnchor.constraint(equalTo: appImageView.centerYAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: Locals.leadingAnchor),
            appNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: Locals.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor)
        ])
    }
}

extension AboutAppViewController: AboutAppDisplayLogic {
    func updateDescription(viewModel: AboutAppModel.AppDescription.ViewModel) {
        descriptionLabel.text = viewModel.description
    }
}
