//
//  ChooseLanguageViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class ChooseLanguageViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let checkmarkColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cellId = "ChooseLanguageCellId"
    }
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    private var languages: [ChooseLanguageModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Locals.backgroundColor
        title = "Learning language"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
        loadLanguages()
    }
    
    // MARK: - Setup UI elements
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = Locals.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChooseLanguageTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       tableView.tableFooterView = UIView()
    }
    
    private func loadLanguages() {
        languages = [ChooseLanguageModel(language: "English", flag: "🇬🇧", code: "en"),
                     ChooseLanguageModel(language: "German", flag: "🇩🇪", code: "de"),
                     ChooseLanguageModel(language: "French", flag: "🇫🇷", code: "fr"),
                     ChooseLanguageModel(language: "Spanish", flag: "🇪🇸", code: "es"),
                     ChooseLanguageModel(language: "Italian", flag: "🇮🇹", code: "it"),
                     ChooseLanguageModel(language: "Polish", flag: "🇵🇱", code: "pl"),
                     ChooseLanguageModel(language: "Turkish", flag: "🇹🇷", code: "tr")]
    }
}

// MARK: - UITableViewDelegate protocol
extension ChooseLanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ChooseLanguageTableViewCell {
            cell.tintColor = Locals.checkmarkColor
            cell.accessoryType = .checkmark
            let userDefaults = UserDefaults.standard
            userDefaults.set(cell.viewModel?.codeValue, forKey: "lang")
        }
    }
}

// MARK: - UITableViewDataSource protocol
extension ChooseLanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? ChooseLanguageTableViewCell {
            cell.viewModel = languages[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}
