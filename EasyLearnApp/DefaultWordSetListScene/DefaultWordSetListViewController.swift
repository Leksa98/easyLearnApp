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

final class DefaultWordSetListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let cellId = "DefaultWordSetListCellId"
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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Word list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadButtonTapped))
        view.backgroundColor = Locals.backgroundColor
        configureTableView()
    }
    
    // MARK: - Configuration
    
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
        tableView.register(WordListTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
    }
    
    @objc private func downloadButtonTapped() {
        let dataHandler = DataHandler()
        if let name = setName, let emoji = setEmoji {
            dataHandler.addWordSetIntoCoreData(name: name, emoji: emoji)
            for word in words {
                dataHandler.addWordtoSet(name: name, word: word.word, translation: word.translation)
            }
        }
    }
}

extension DefaultWordSetListViewController: UITableViewDelegate { }

extension DefaultWordSetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordListTableViewCell {
            cell.viewModel = words[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension DefaultWordSetListViewController: DefaultWordSetListDataSource {
    func presentWordSet(name: String, emoji: String, words: [WordModel]) {
        self.words = words
        self.setName = name
        self.setEmoji = emoji
    }
}
