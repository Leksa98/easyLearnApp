//
//  WordOfDayViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 18.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordOfDayDisplay: class {
    func updateContent(viewModel: WordOfDayModel.FetchWordOfDay.ViewModel)
}

struct WordOfDaySection {
    let name: String
    var content: [String]
}

final class WordOfDayViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let lineViewHeightAnchor: CGFloat = 0.5
        static let cellId = "WordOfDayTableViewCellId"
        static let tableRowHeight: CGFloat = 44
        static let wordLabelTextSize: CGFloat = 20
        static let sectionHeaderTextSize: CGFloat = 18
        static let dateLabelTextSize: CGFloat = 16
        
        static let topAnchor: CGFloat = 10
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let bottomAnchor: CGFloat = -10
        static let distanceBetweenLabels: CGFloat = 10
        
        static let noteNumberOfLines = 0
        static let headerHeight: CGFloat = 20
    }
    
    // MARK: - Properties
    
    private var wordLabel = UILabel()
    private var dateLabel = UILabel()
    private var dateValueLabel = UILabel()
    private var noteLabel = UILabel()
    private var noteValueLabel = UILabel()
    private var lineView = UIView()
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var sections: [WordOfDaySection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
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
    }
    
    // MARK: - Setup UI elements
    
    private func setUpLabels() {
        view.addSubview(wordLabel)
        view.addSubview(dateLabel)
        view.addSubview(noteLabel)
        view.addSubview(lineView)
        
        wordLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.wordLabelTextSize)
        noteLabel.numberOfLines = Locals.noteNumberOfLines
        lineView.backgroundColor = .lightGray
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
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
            
            noteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Locals.distanceBetweenLabels),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20),
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
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableRowHeight
        }
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: Locals.headerHeight))
        headerView.text = sections[section].name
        headerView.font = UIFont.sfProTextHeavy(ofSize: Locals.sectionHeaderTextSize)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Locals.headerHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? WordOfDayTableViewCell {
            let section = self.sections[indexPath.section]
            cell.viewModel = section.content[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension WordOfDayViewController: WordOfDayDisplay {
    func updateContent(viewModel: WordOfDayModel.FetchWordOfDay.ViewModel) {
        DispatchQueue.main.async {
            let attrs1 = [NSAttributedString.Key.font: UIFont.sfProTextHeavy(ofSize: Locals.dateLabelTextSize) ?? UIFont.boldSystemFont(ofSize: Locals.dateLabelTextSize), NSAttributedString.Key.foregroundColor: UIColor.black]
            let attrs2 = [NSAttributedString.Key.font: UIFont.sfProTextMedium(ofSize: Locals.dateLabelTextSize) ?? UIFont.systemFont(ofSize: Locals.dateLabelTextSize), NSAttributedString.Key.foregroundColor: UIColor.customDarkGray]
            let attributedDateString = NSMutableAttributedString(string: "Date: ", attributes: attrs1)
            attributedDateString.append(NSMutableAttributedString(string: viewModel.wordOfDay.dateValue, attributes: attrs2))
            let attributedNoteString = NSMutableAttributedString(string: "Note: ", attributes: attrs1)
            attributedNoteString.append(NSMutableAttributedString(string: viewModel.wordOfDay.noteValue, attributes: attrs2))
            self.wordLabel.text = viewModel.wordOfDay.wordValue.capitalizingFirstLetter()
            self.dateLabel.attributedText = attributedDateString
            self.noteLabel.attributedText = attributedNoteString
            var wordDefinition: [String] = []
            viewModel.wordOfDay.definitionValue.forEach { definition in
                wordDefinition.append(definition.partOfSpeechValue + ": " + definition.definitionValue)
            }
            self.sections.append(WordOfDaySection(name: "Definitions", content: wordDefinition))
            self.sections.append(WordOfDaySection(name: "Examples", content: viewModel.wordOfDay.exampleValue))
        }
    }
}
