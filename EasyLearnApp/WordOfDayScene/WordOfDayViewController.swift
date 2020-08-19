//
//  WordOfDayViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordOfDayDisplay: class {
    
}

final class WordOfDayViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let lineViewHeightAnchor: CGFloat = 0.7
        static let cellId = "WordOfDayTableViewCellId"
        static let tableRowHeight: CGFloat = 44
        static let wordLabelTextSize: CGFloat = 20
        static let dateLabelTextSize: CGFloat = 15
        static let topAnchor: CGFloat = 10
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let bottomAnchor: CGFloat = -10
        static let distanceBetweenLabels: CGFloat = 5
    }
    
    // MARK: - Properties
    
    private var wordLabel = UILabel()
    private var dateLabel = UILabel()
    private var lineView = UIView()
    private var tableView = UITableView()
    var interactor: WordOfDayInteractor?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationItem.title = "Word of the day"
        setUpLabels()
        setUpTableView()
        interactor?.fetchWordOfDay()
    }
    
    // MARK: - Setup UI elements
    
    private func setUpLabels() {
        view.addSubview(wordLabel)
        view.addSubview(dateLabel)
        view.addSubview(lineView)
        
        wordLabel.text = "Ademption"
        wordLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.wordLabelTextSize)
        
        dateLabel.text = "Date: 2020-08-18"
        dateLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.dateLabelTextSize)
        
        lineView.backgroundColor = .lightGray
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            wordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.topAnchor).isActive = true
        } else {
            wordLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Locals.topAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Locals.lineViewHeightAnchor),
        ])
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordOfDayTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableRowHeight
        }
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: Locals.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor)
        ])
        if #available(iOS 11.0, *) {
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Locals.bottomAnchor).isActive = true
        } else {
            tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: Locals.bottomAnchor).isActive = true
        }
    }
}

extension WordOfDayViewController: UITableViewDelegate { }

extension WordOfDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordOfDayTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

extension WordOfDayViewController: WordOfDayDisplay {
    
}
