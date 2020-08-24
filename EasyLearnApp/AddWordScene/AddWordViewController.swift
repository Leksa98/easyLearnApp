//
//  AddWordTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 15.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit
import Foundation

protocol UpdateTranslations: class {
    func updateTranslations(viewModel: AddWordModel.WordTranslations.ViewModel)
}

protocol AddWordDataStore {
    var addWord: WordModel { get set }
}

final class AddWordViewController: UIViewController, AddWordDataStore {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellId = "addWordTableViewCell"
        static let tableViewRowHeight: CGFloat = 44
        static let buttonLeadingAnchor: CGFloat = 10
        static let buttonTrailingAnchor: CGFloat = -10
        static let buttonBottomAnchor: CGFloat = -30
        static let buttonTopAnchor: CGFloat = 10
    }
    
    // MARK: - Properties
    
    private var wordSearchController: UISearchController! = nil
    private var translations: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if let text = self.searchBar.text {
                    self.addWord.word = text
                }
            }
        }
    }
    private var tableView =  UITableView()
    private var searchBar = UISearchBar()
    private var addButton = ButtonWithRoundCorners(title: "Add")
    private var isKeyboardVisible = false
    var interactor: FetchWordTranslations?
    var router: AddWordRoutingLogic?
    var addWord = WordModel(word: "", translation: "")
    var delegete: AddWordToSetDataStore?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchBar()
        configureTableView()
        configureAddTranslationButton()
        dismissKey()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.setPlaceholderTextColorTo(color: UIColor.blueSapphire)
    }
    
    // MARK: - Configuration
    
    private func configureSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.clipsToBounds = true
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        let language = (UserDefaults.standard.object(forKey: "selectedLanguage") as? String) ?? "English"
        searchBar.placeholder = "Type word in \(language)..."
        searchBar.sizeToFit()
        searchBar.barTintColor = UIColor.blueSapphire
        searchBar.textField?.backgroundColor = .white
        if let glassIconView = searchBar.textField?.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor.blueSapphire
        }
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(.white, for: .normal)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            searchBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddWordTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
    
    private func configureAddTranslationButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.buttonLeadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.buttonTrailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Locals.buttonBottomAnchor),
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Locals.buttonTopAnchor),
        ])
    }
    
    @objc private func closeView() {
        if !addWord.word.isEmpty && !addWord.translation.isEmpty, let delegate = delegete {
            router?.routeToAddSetView(source: self, destination: delegate)
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension AddWordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addWord.translation = translations[indexPath.row]
    }
}

// MARK: - UITableViewDataSource protocol
extension AddWordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if translations.count == 0 {
            tableView.backgroundView = AddWordTableEmptyView()
        } else {
            tableView.backgroundView = nil
        }
        return translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddWordTableViewCell {
            cell.viewModel = WordModel(word: searchBar.text ?? "", translation: translations[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: - UISearchBarDelegate protocol
extension AddWordViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let text = searchBar.text else {
            return
        }
        interactor?.fetchWordTranslations(request: AddWordModel.WordTranslations.Request(word: text))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if translations.isEmpty && ((searchBar.text?.isEmpty) != nil) {
            router?.routeBack(source: self)
        } else {
            searchBar.text = ""
            translations = []
        }
    }
}

// MARK: - UpdateTranslations protocol
extension AddWordViewController: UpdateTranslations {
    func updateTranslations(viewModel: AddWordModel.WordTranslations.ViewModel) {
        translations = viewModel.translations
    }
}
