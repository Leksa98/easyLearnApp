//
//  AddWordTableViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 15.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

class AddWordViewController: UIViewController {
    
    private var wordSearchController: UISearchController! = nil
    var translations: [String] = []
    private var tableView =  UITableView()
    private var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.83, green: 1, blue: 0.96, alpha: 1))
        configureSearchBar()
        configureTableView()
        dismissKey()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.setPlaceholderTextColorTo(color: UIColor(cgColor: CGColor(srgbRed:0.53, green: 0.85, blue: 0.75, alpha: 1)))
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.addSubview(searchBar)
        
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 15
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Type word..."
        searchBar.sizeToFit()
        searchBar.barTintColor = UIColor(cgColor: CGColor(srgbRed:0.53, green: 0.85, blue: 0.75, alpha: 1))
        searchBar.searchTextField.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.83, green: 1, blue: 0.96, alpha: 1))
        searchBar.searchTextField.leftView?.tintColor = UIColor(cgColor: CGColor(srgbRed:0.53, green: 0.85, blue: 0.75, alpha: 1))
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitleColor(UIColor(cgColor: CGColor(srgbRed: 0.83, green: 1, blue: 0.96, alpha: 1)), for: .normal)
            cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddWordTableViewCell.self, forCellReuseIdentifier: "addWordTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.83, green: 1, blue: 0.96, alpha: 1))
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
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UISearchBarDelegate
extension AddWordViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard let text = searchBar.text else {
            return
        }
        let translationMeaningsParser = TranslationMeaningsParser()
        translationMeaningsParser.getWordMeaning(word: text) { translation, error in
        if let error = error {
            print(error)
        }
        if let translation = translation {
            print(translation)
            self.translations = translation
        }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
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
        tableView.reloadData()
    }
}

extension UISearchBar {
    func setPlaceholderTextColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        textFieldInsideSearchBar?.font = .boldSystemFont(ofSize: 20)
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
}
