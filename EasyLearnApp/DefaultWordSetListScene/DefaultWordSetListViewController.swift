//
//  DefaultWordSetListViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 05.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol DefaultWordSetListDataSource: class {
    func presentWordSet(name: String, emoji: String, words: [WordModel])
}

protocol DefaultWordSetListSaveNotification: class {
    func showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel)
}

final class DefaultWordSetListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellId = "DefaultWordSetListCellId"
        static let tableViewRowHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var setName: String?
    private var setEmoji: String?
    private var words: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let alertView = CustomAlertView()
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    var interactor: DefaultWordSetListBusinessLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Word list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadButtonTapped))
        view.backgroundColor = .white
        configureTableView()
    }
    
    // MARK: - Configuration
    
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
        tableView.register(AddSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
    
    @objc private func downloadButtonTapped() {
        if let name = setName, let emoji = setEmoji {
            interactor?.downloadWordSet(request: DefaultWordSetListModel.DownloadWordSet.Request(name: name, emoji: emoji, words: words))
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension DefaultWordSetListViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource protocol
extension DefaultWordSetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddSetTableViewCell {
            cell.viewModel = words[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - DefaultWordSetListDataSource protocol
extension DefaultWordSetListViewController: DefaultWordSetListDataSource {
    func presentWordSet(name: String, emoji: String, words: [WordModel]) {
        self.words = words
        self.setName = name
        self.setEmoji = emoji
    }
}

// MARK: - DefaultWordSetListSaveNotification protocol
extension DefaultWordSetListViewController: DefaultWordSetListSaveNotification {
    func showSaveAlert(viewModel: DefaultWordSetListModel.DownloadWordSet.ViewModel) {
        view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        alertView.titleLabel.text = "Saved"
        alertView.messageLabel.text = "Set \(viewModel.name) \(viewModel.emoji) was saved!"
        alertView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 150),
        ])
        /*let savedAlert = UIAlertController(title: "Saved", message: "Set \(viewModel.name) \(viewModel.emoji) was saved!", preferredStyle: .alert)
        savedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(savedAlert, animated: true, completion: nil)*/
    }
    
    @objc private func buttonPressed() {
        visualEffectView.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}
