//
//  WordListTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 24.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordListTablePresentationLogic {
    func showWordList(setName: String)
}

final class WordListTableViewController: UIViewController {
    
    enum Locals {
        static let cellId = "WordListCellId"
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
    }

    private var tableView =  UITableView()
    private var wordDictionary: [String: String]? {
        didSet {
            if let wordDictionary = wordDictionary {
                wordArray = []
                translationArray = []
                for item in wordDictionary {
                    words.append(WordModel(word: item.key, translation: item.value))
                }
                tableView.reloadData()
            }
        }
    }
    private var wordArray: [String] = []
    private var translationArray: [String] = []
    private var words: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var setName: String?
    private var interactor: WordSetListBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Locals.backgroundColor
        title = "List"
        navigationItem.rightBarButtonItem = self.editButtonItem
        configureTable()
        let interactor = WordSetListInteractor()
        self.interactor = interactor
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        tableView.register(WordListTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = Locals.backgroundColor
    }
}


extension WordListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordListTableViewCell {
            cell.viewModel = words[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let word = words[indexPath.row]
            words.remove(at: indexPath.row)
            if let setName = setName {
                interactor?.deleteWordFromSet(set: setName, word: word.word)
            }
        }
    }
}


extension WordListTableViewController: WordListTablePresentationLogic {
    func showWordList(setName: String) {
        let dataHandler = DataHandler()
        self.setName = setName
        wordDictionary = dataHandler.fetchWords(from: setName)
    }
}
