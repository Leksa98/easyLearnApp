//
//  WordListTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordListTablePresentationLogic: class {
    func showWordList(viewModel: WordSetListModel.FetchWordSet.ViewModel)
}

final class WordListViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellId = "WordListCellId"
    }
    
    // MARK: - Properties

    private var tableView =  UITableView()
    private var wordArray: [String] = []
    private var translationArray: [String] = []
    private var wordsInSet: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var setName: String?
    var interactor: WordSetListBusinessLogic?
    var router: WordSetListRouterLogic?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        configureTable()
    }
    
    // MARK: - Setup UI elements
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        }
        tableView.register(AddSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = 44
        }
    }
    
    // MARK: - Button actions
    
    @objc private func addTapped() {
        router?.routeToAddWordScene(viewController: self)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsInSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddSetTableViewCell {
            cell.viewModel = wordsInSet[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let word = wordsInSet[indexPath.row].word
            wordsInSet.remove(at: indexPath.row)
            if let setName = setName {
                interactor?.deleteWordFromSet(request: WordSetListModel.DeleteWordFromSet.Request(set: setName, word: word))
            }
        }
    }
}

//MARK: - WordListTablePresentationLogic protocol
extension WordListViewController: WordListTablePresentationLogic {
    func showWordList(viewModel: WordSetListModel.FetchWordSet.ViewModel) {
        wordsInSet = viewModel.words
    }
}

//MARK: - AddWordToSetDataStore protocol
extension WordListViewController: AddWordToSetDataStore {
    func addWordToArray(word: WordModel) {
        wordsInSet.append(word)
        if let setName = setName {
            interactor?.addWordToSet(request: WordSetListModel.AddWordToSet.Request(setName: setName, word: word))
        }
    }
}
