//
//  WordSetTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol ShowWordSets: class {
    func showWordSets(sets: [WordSetModel])
}

final class WordSetTableViewController: UITableViewController {
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
    }
    
    // MARK: - Properties
    
    var interactor: WordSetTableBussinesLogic?
    private var studySet: [WordSetModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = WordSetTableInteractor()
        let presenter = WordSetTablePresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        loadData()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        view.backgroundColor = Locals.backgroundColor
        navigationItem.title = "My sets"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(WordSetTableViewCell.self, forCellReuseIdentifier: "wordSetCell")
        navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let setName = studySet[indexPath.row]
            studySet.remove(at: indexPath.row)
            interactor?.deletefromCoreData(setName: setName.nameValue)
        }
    }
}


extension WordSetTableViewController: ShowWordSets {
    func showWordSets(sets: [WordSetModel]) {
        self.studySet = sets
    }
}
