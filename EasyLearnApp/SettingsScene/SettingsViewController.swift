//
//  SettingsViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 06.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

struct SettingsSection {
    let cellName: [String]
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let chooseLanguageCellId = "chooseLanguageCellId"
        static let tableViewRowHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let sections = [SettingsSection(cellName: [NSLocalizedString("settings_about_app_section", comment: "")]), SettingsSection(cellName: [NSLocalizedString("settings_language_to_study_section", comment: "")])]
    var router: SettingsRouterLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("settings_title", comment: "")
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.tintColor = UIColor.blueSapphire
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup UI elements
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: Locals.chooseLanguageCellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
            if cell.viewModel == NSLocalizedString("settings_language_to_study_section", comment: "") {
                router?.routeToChooseLanguageScene()
            } else if cell.viewModel == NSLocalizedString("settings_about_app_section", comment: "") {
                router?.routeToAboutAppScene()
            }
        }
    }
}

// MARK: - UITableViewDataSource protocol
extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.chooseLanguageCellId, for: indexPath) as? SettingsTableViewCell {
            let section = self.sections[indexPath.section]
            cell.viewModel = section.cellName[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
