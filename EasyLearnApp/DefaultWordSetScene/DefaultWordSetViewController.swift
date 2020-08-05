//
//  DefaultWordSetViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol DefaultWordSetShowLogic: class {
    func showDefaultSets(sets: [WordSetModel])
}

final class DefaultWordSetViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let cellId = "DefaultWordSetCellId"
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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Default sets"
        view.backgroundColor = Locals.backgroundColor
        tabBarController?.tabBar.isHidden = true
        configureTableView()
        
        let interactor = DefaultWordSetInteractor()
        self.interactor = interactor
        let presenter = DefaultWordSetPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        interactor.fetchDefaultSet()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = Locals.backgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(DefaultWordSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
    }
}

// MARK: - UITableViewDelegate protocol
extension DefaultWordSetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let delegete: DefaultWordSetListDataSource = DefaultWordSetListViewController()
        let words = defaultSets[indexPath.row].wordsValue
        let name = defaultSets[indexPath.row].nameValue
        let emoji = defaultSets[indexPath.row].emojiValue
        navigationController?.pushViewController(delegete as! UIViewController, animated: true)
        delegete.presentWordSet(name: name, emoji: emoji, words: words)
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

extension DefaultWordSetViewController : DefaultWordSetShowLogic {
    func showDefaultSets(sets: [WordSetModel]) {
        defaultSets = sets
    }
}

