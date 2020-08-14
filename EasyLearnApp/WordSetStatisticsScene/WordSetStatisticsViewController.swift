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
        
        static let labelLeadingAnchor: CGFloat = 15
        static let labelTrailingAnchor: CGFloat = -15
        static let topAnchor: CGFloat = 10
        
        static let progressLabelSize: CGFloat = 18
        
        static let progressViewLeadingAnchor: CGFloat = 10
        static let progressViewTrailingAnchor: CGFloat = -10
        static let progressViewHeight: CGFloat = 20
        
        static let tableViewRowHeight: CGFloat = 44
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
    private var currentProgressLabel = UILabel()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Locals.title
        setUpProgressLabel()
        setUpProgressBar()
        configureTableView()
        if let setTitle = setTitle {
            interactor?.fetchWords(request: WordSetStatisticsModel.FetchWordSet.Request(setName: setTitle))
        }
    }
    
    // MARK: - Setup UI elements
    
    private func setUpProgressLabel() {
        view.addSubview(currentProgressLabel)
        currentProgressLabel.text = "Current progress"
        currentProgressLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.progressLabelSize)
        currentProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                currentProgressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.labelLeadingAnchor),
                currentProgressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.labelTrailingAnchor),
                currentProgressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.topAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                currentProgressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.labelLeadingAnchor),
                currentProgressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.labelTrailingAnchor),
                currentProgressLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Locals.topAnchor),
            ])
        }
    }
    
    private func setUpProgressBar() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.progressViewLeadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.progressViewTrailingAnchor),
            progressView.topAnchor.constraint(equalTo: currentProgressLabel.bottomAnchor, constant: Locals.topAnchor),
            progressView.heightAnchor.constraint(equalToConstant: Locals.progressViewHeight)
        ])
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordSetStatisticsTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: Locals.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: Locals.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordSetStatisticsTableViewCell {
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
