//
//  DefaultWordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol DefaultWordSetShowLogic: class {
    func showDefaultSets(viewModel: DefaultWordSetModel.FetchDefaultSets.ViewModel)
}

final class DefaultWordSetViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellId = "DefaultWordSetCellId"
        static let tableViewRowHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var defaultSets: [WordSetModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var interactor: DefaultWordSetBusinessLogic?
    var router: DefaultWordSetRouterLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("default_word_set_title", comment: "")
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        configureTableView()
        interactor?.fetchDefaultSet(request: DefaultWordSetModel.FetchDefaultSets.Request())
    }
    
    // MARK: - Setup UI elements
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        tableView.register(DefaultWordSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension DefaultWordSetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let words = defaultSets[indexPath.row].wordsValue
        let name = defaultSets[indexPath.row].nameValue
        let emoji = defaultSets[indexPath.row].emojiValue
        router?.routeToDefaultWordSetList(name: name, emoji: emoji, words: words)
    }
}

// MARK: - UITableViewDataSource protocol
extension DefaultWordSetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        defaultSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? DefaultWordSetTableViewCell {
            cell.viewModel = defaultSets[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
}

// MARK: - DefaultWordSetShowLogic protocol
extension DefaultWordSetViewController: DefaultWordSetShowLogic {
    func showDefaultSets(viewModel: DefaultWordSetModel.FetchDefaultSets.ViewModel) {
        defaultSets = viewModel.sets
    }
}
