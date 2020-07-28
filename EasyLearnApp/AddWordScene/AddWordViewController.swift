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
    func updateTranslations(trans: [String])
}

protocol AddWordDataStore {
    var addWord: WordModel { get set }
}

final class AddWordViewController: UIViewController, UpdateTranslations, AddWordDataStore {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cellId = "addWordTableViewCell"
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
    private var addTranslationButton = ButtonWithRoundCorners(title: "Add")
    var interactor: FetchWordTranslations?
    var router: AddWordRoutingLogic?
    var addWord = WordModel(word: "", translation: "")
    var delegete: AddWordToSetDataStore?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = AddWordInteractor()
        let presenter = AddWordPresenter()
        let router = AddWordRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        
        view.backgroundColor = Locals.backgroundColor
        configureSearchBar()
        configureTableView()
        configureAddTranslationButton()
        dismissKey()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.setPlaceholderTextColorTo(color: Locals.buttonColor)
    }
    
    // MARK: - Configuration
    
    private func configureSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.addSubview(searchBar)
        searchBar.clipsToBounds = true
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Type word in english..."
        searchBar.sizeToFit()
        searchBar.barTintColor = Locals.buttonColor
        searchBar.searchTextField.backgroundColor = Locals.backgroundColor
        searchBar.searchTextField.leftView?.tintColor = Locals.buttonColor
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(Locals.backgroundColor, for: .normal)
            cancelButton.titleLabel?.font = .systemFont(ofSize: 16)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddWordTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Locals.backgroundColor
    }
    
    private func configureAddTranslationButton() {
        view.addSubview(addTranslationButton)
        addTranslationButton.backgroundColor = Locals.buttonColor
        addTranslationButton.translatesAutoresizingMaskIntoConstraints = false
        addTranslationButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addTranslationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTranslationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTranslationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addTranslationButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
        ])
    }
    
    @objc private func closeView() {
        if !addWord.word.isEmpty && !addWord.translation.isEmpty, let delegate = delegete {
            router?.routeToAddSetView(source: self, destination: delegate)
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension AddWordViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddWordTableViewCell {
            cell.viewModel = translations[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addWord.translation = translations[indexPath.row]
    }
}


// MARK: - UISearchBarDelegate
extension AddWordViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let text = searchBar.text else {
            return
        }
        interactor?.fetchWordTranslations(word: text)
    }
    
    func updateTranslations(trans: [String]) {
        translations = trans
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        translations = []
    }
}
