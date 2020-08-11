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
    func showStatistics(viewModel: WordSetStatisticsModel.FetchWordSet.ViewModel)
}

final class WordSetStatisticsViewController: UIViewController, WordSetStatisticsDataSource {
    
    // MARK: - Constants
    
    enum Locals {
        static let title = "Statistics"
        static let cellId = "WordSetStatusticsCellId"
    }
    
    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var sections: [WordStatisticsSectionModel] = [] {
        didSet {
            var wordsAmount = sections.reduce(0) { $0 + $1.wordsValue.count }
            let firstSection = sections.first?.wordsValue.count ?? 0
            let lastSection = sections.last?.wordsValue.count ?? 0
            let secondSection = wordsAmount - firstSection - lastSection
            
            wordsAmount = wordsAmount ==  0 ? 1 : wordsAmount
            print(CGFloat(Float(firstSection)/Float(wordsAmount)),
                  CGFloat(Float(secondSection)/Float(wordsAmount)),
                  CGFloat(Float(lastSection)/Float(wordsAmount)))
            
            progressView.setProgress(firstSection: CGFloat(Float(lastSection)/Float(wordsAmount)),
                                     secondSection: CGFloat(Float(secondSection)/Float(wordsAmount)),
                                     thirdSection: CGFloat(Float(firstSection)/Float(wordsAmount)))
            progressView.setNeedsDisplay()
            tableView.reloadData()
        }
    }
    var setTitle: String?
    var interactor: WordSetStatisticsBusinessLogic?
    private var progressView = ProgressBarView()
    
    private var firstProgressBar = UIProgressView()
    private var secondProgressBar = UIProgressView()
    private var thirdProgressBar = UIProgressView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Locals.title
        setUpProgressBar()
        configureTableView()
        if let setTitle = setTitle {
            interactor?.fetchWords(request: WordSetStatisticsModel.FetchWordSet.Request(setName: setTitle))
        }
    }
    
    // MARK: - Setup UI elements
    
    private func setUpProgressBar() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordListTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
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
    func showStatistics(viewModel: WordSetStatisticsModel.FetchWordSet.ViewModel) {
        self.sections = viewModel.sections
    }
}
