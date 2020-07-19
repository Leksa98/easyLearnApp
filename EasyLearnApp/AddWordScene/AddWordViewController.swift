//
//  AddWordTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 15.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit
import Foundation

protocol Update {
    func update(trans: [String])
}
class AddWordViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
    }
    
    // MARK: - Properties
    
    private var wordSearchController: UISearchController! = nil
    private var translations: [String] = []
    private var tableView =  UITableView()
    private var searchBar = UISearchBar()
    private var addTranslationButton = ButtonWithRoundCorners(title: "Add")
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        searchBar.placeholder = "Type word..."
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
        tableView.register(AddWordTableViewCell.self, forCellReuseIdentifier: "addWordTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = Locals.backgroundColor
    }
    
    private func configureAddTranslationButton() {
        view.addSubview(addTranslationButton)
        addTranslationButton.backgroundColor = Locals.buttonColor
        addTranslationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTranslationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTranslationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTranslationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            addTranslationButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
        ])
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addWordTableViewCell", for: indexPath) as? AddWordTableViewCell {
            cell.viewModel = translations[indexPath.row]
            cell.backgroundColor = Locals.backgroundColor
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(translations[indexPath.row])
    }
}


// MARK: - UISearchBarDelegate
extension AddWordViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let text = searchBar.text else {
            return
        }
        let presenter = AddWordInteractor()
        presenter.showTranslations(word: text)
        /*let translationMeaningsParser = TranslationMeaningsParser()
        translationMeaningsParser.getWordMeaning(word: text) { translation, error in
            if let error = error {
                print(error)
            }
            if let translation = translation {
                self.update(trans: translation)
            }
        }*/
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func update(trans: [String]) {
        translations = trans
        print(translations)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.dismissKeyboard()
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
        self.translations = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
