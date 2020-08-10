//
//  ChooseLanguageViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol ChooseLanguageShowTableView: class {
    func loadDataInTableView(viewModel: ChooseLanguageModel.Language.ViewModel)
}

final class ChooseLanguageViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellId = "ChooseLanguageCellId"
    }
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    private var selectedCell: IndexPath?
    private var languages: [LanguageModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var interactor: ChooseLanguageBusinessLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Learning language"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
        interactor?.loadLanguages(request: ChooseLanguageModel.Language.Request())
    }
    
    // MARK: - Setup UI elements
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
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
}

// MARK: - UITableViewDelegate protocol
extension ChooseLanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ChooseLanguageTableViewCell {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ChooseLanguageTableViewCell {
            if let selectedCell = selectedCell {
                tableView.cellForRow(at: selectedCell)?.accessoryType = .none
            }
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
            let userDefaults = UserDefaults.standard
            
            let lang = userDefaults.object(forKey: "lang")
            switch lang as? String {
            case languages[indexPath.row].codeValue:
                selectedCell = indexPath
                cell.accessoryType = .checkmark
            case nil:
                if languages[indexPath.row].codeValue == "en" {
                    selectedCell = indexPath
                    cell.accessoryType = .checkmark
                }
            default:
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - ChooseLanguageShowTableView protocol
extension ChooseLanguageViewController: ChooseLanguageShowTableView {
    func loadDataInTableView(viewModel: ChooseLanguageModel.Language.ViewModel) {
        self.languages = viewModel.languages
    }
}
