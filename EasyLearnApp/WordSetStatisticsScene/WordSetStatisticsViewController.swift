//
//  WordSetStatisticsViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetStatisticsDataSource {
    var setTitle: String? { get set }
}

protocol WordSetStatisticsShow: class {
    func showStatistics(sections: [WordStatisticsSection])
}

final class WordSetStatisticsViewController: UIViewController, WordSetStatisticsDataSource {
    
    // MARK: - Constants
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let title = "Statistics"
        static let cellId = "WordSetStatusticsCellId"
    }
    
    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var sections: [WordStatisticsSection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var setTitle: String?
    var interactor: WordSetStatisticsBusinessLogic?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Locals.backgroundColor
        title = Locals.title
        configureTableView()
        if let setTitle = setTitle {
            interactor?.fetchWords(setName: setTitle)
        }
    }
    
    // MARK: - Configuration
    
    private func configureTableView() {
        tableView.backgroundColor = Locals.backgroundColor
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordListTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

 // MARK: - UITableViewDelegate protocol
extension WordSetStatisticsViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource protocol
extension WordSetStatisticsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].nameValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].wordsValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordListTableViewCell {
            cell.viewModel = sections[indexPath.section].wordsValue[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - WordSetStatisticsShow protocol
extension WordSetStatisticsViewController: WordSetStatisticsShow {
    func showStatistics(sections: [WordStatisticsSection]) {
        self.sections = sections
    }
}
