//
//  WordSetTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AllWordSetTableShow: class {
    func showWordSets(sets: [WordSetModel])
}

final class WordSetTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cellId = "wordSetCell"
    }
    
    // MARK: - Properties
    
    var interactor: WordSetTableBusinessLogic?
    var router: WordSetTableRouterLogic?
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
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        view.backgroundColor = Locals.backgroundColor
        navigationItem.title = "My sets"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(WordSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.tintColor = Locals.buttonColor
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        interactor?.fetchStudySets()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studySet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordSetTableViewCell {
            cell.viewModel = studySet[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToWordSetDetails(with: studySet[indexPath.row].nameValue)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let setName = studySet[indexPath.row]
            studySet.remove(at: indexPath.row)
            interactor?.deletefromCoreData(setName: setName.nameValue)
        }
    }
}

// MARK: - AllWordSetTableShow protocol
extension WordSetTableViewController: AllWordSetTableShow {
    func showWordSets(sets: [WordSetModel]) {
        self.studySet = sets
    }
}
