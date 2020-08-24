//
//  WordSetTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AllWordSetTableShow: class {
    func showWordSets(viewModel: AllWordSetTableModel.FetchStudySets.ViewModel)
}

final class AllWordSetTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellId = "wordSetCell"
        static let tableRowHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    
    var interactor: AllWordSetTableBusinessLogic?
    var router: AllWordSetTableRouterLogic?
    private var studySet: [WordSetModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        interactor?.fetchStudySets(request: AllWordSetTableModel.FetchStudySets.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.fetchStudySets(request: AllWordSetTableModel.FetchStudySets.Request())
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup UI elements
    
    private func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "My sets"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        tableView.register(AllWordSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        navigationController?.navigationBar.tintColor = UIColor.blueSapphire
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableRowHeight
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studySet.count == 0 {
            let backgroundView = AllWordSetEmptyView()
            backgroundView.tabBarController = tabBarController
            tableView.backgroundView = backgroundView
        } else {
            tableView.backgroundView = nil
        }
        return studySet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AllWordSetTableViewCell {
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
            interactor?.deletefromCoreData(request: AllWordSetTableModel.DeleteSet.Request(setName: setName.nameValue))
        }
    }
}

// MARK: - AllWordSetTableShow protocol
extension AllWordSetTableViewController: AllWordSetTableShow {
    func showWordSets(viewModel: AllWordSetTableModel.FetchStudySets.ViewModel) {
        self.studySet = viewModel.studySets
    }
}
