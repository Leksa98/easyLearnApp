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
        static let alertViewWidth: CGFloat = 300
        static let alertViewHeight: CGFloat = 150
        static let alertTransformScale: CGFloat = 1.3
        static let animationDuration: TimeInterval = 0.4
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
    private let alertView = CustomAlertWithBackgroundView()
    var interactor: DefaultWordSetListBusinessLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("default_word_set_list_title", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("default_word_set_download_button", comment: ""), style: .plain, target: self, action: #selector(downloadButtonTapped))
        view.backgroundColor = .white
        configureTableView()
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
        tableView.register(AddSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
    
    // MARK: - Button actions
    
    @objc private func downloadButtonTapped() {
        alertView.screenshotImageView.image = UIApplication.shared.takeScreenshot()
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
        alertView.navigationController = navigationController
        alertView.alertView.titleLabel.text = viewModel.alertTitleLabel
        alertView.alertView.messageLabel.text = viewModel.alertMessageLabel
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: view.topAnchor),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        alertView.showAlert()
    }
}
