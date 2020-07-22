//
//  WordSetTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class WordSetTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var studySet: [WordSetModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "My sets"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(WordSetTableViewCell.self, forCellReuseIdentifier: "wordSetCell")
        navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func loadData() {
        let dataHandler = DataHandler()
        let sets = dataHandler.fetchAllWordSetRecord()
        studySet = []
        if let sets = sets {
            sets.forEach { set in
                self.studySet.append(WordSetModel(name: set.name!, emoji: set.emoji!))
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studySet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wordSetCell", for: indexPath) as? WordSetTableViewCell {
            cell.viewModel = studySet[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let presenter: WordSetPresentationLogic = WordSetViewController()
        navigationController?.pushViewController(presenter as! UIViewController, animated: true)
        presenter.presentWordSet(wordSet: studySet[indexPath.row])
    }
}
