//
//  ViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol AddWordToSetDataStore {
    func addWordToArray(word: WordModel)
}

protocol AddSetSavedNotification: class {
    func showSavedAlert(name: String, emoji: String)
}

final class AddSetViewController: UIViewController {

    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let borderColor = UIColor(cgColor: CGColor(srgbRed: 84.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 1)).cgColor
        static let viewColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        static let cellId = "addSetTableViewCell"
    }
    
    // MARK: - Properties
    
    private var addWordButton = ButtonWithRoundCorners(title: "Add word")
    private var nameView = EnterInfoView(label: "Set Title", textField: "Enter set title")
    private var emojiView = EnterInfoView(label: "Set Emoji", textField: "Enter set emoji")
    private var wordSetView = UIView()
    private var addedWordTableView = UITableView()
    private var addedWords: [WordModel] = [] {
        didSet {
            addedWordTableView.reloadData()
        }
    }
    var interactor: AddSetBusinessLogic?
    var router: AddSetRouterLogic?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        configureView()
        dismissKey()
        configureNameView()
        configureEmojiView()
        configuteTableView()
        setAddButton()
    }
    
    // MARK: - Setup UI elements
    
    private func configureView() {
        title = "Add new set"
        view.backgroundColor = Locals.backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Locals.buttonColor
    }
    
    private func setAddButton() {
        addWordButton.addTarget(self, action: #selector(addWordButtonTapped), for: .touchUpInside)
        view.addSubview(addWordButton)
        addWordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addWordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addWordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addWordButton.topAnchor.constraint(equalTo: wordSetView.bottomAnchor, constant: 10),
            addWordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureEmojiView() {
        view.addSubview(emojiView)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emojiView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            emojiView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureNameView() {
        view.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configuteTableView() {
        view.addSubview(wordSetView)
        wordSetView.backgroundColor = Locals.viewColor
        wordSetView.layer.borderWidth = 2
        wordSetView.layer.borderColor = Locals.borderColor
        wordSetView.layer.cornerRadius = 15
        wordSetView.addSubview(addedWordTableView)
        let tableLabel = UILabel()
        tableLabel.text = "Added words"
        tableLabel.font = .boldSystemFont(ofSize: 20)
        wordSetView.addSubview(tableLabel)
        addedWordTableView.backgroundColor = Locals.viewColor
        addedWordTableView.delegate = self
        addedWordTableView.dataSource = self
        addedWordTableView.register(AddSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        addedWordTableView.separatorStyle = .none
        wordSetView.translatesAutoresizingMaskIntoConstraints = false
        addedWordTableView.translatesAutoresizingMaskIntoConstraints = false
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordSetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wordSetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            wordSetView.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 10),
            tableLabel.leadingAnchor.constraint(equalTo: wordSetView.leadingAnchor, constant: 15),
            tableLabel.trailingAnchor.constraint(equalTo: wordSetView.trailingAnchor, constant: -15),
            tableLabel.topAnchor.constraint(equalTo: wordSetView.topAnchor, constant: 15),
            addedWordTableView.leadingAnchor.constraint(equalTo: wordSetView.leadingAnchor, constant: 5),
            addedWordTableView.trailingAnchor.constraint(equalTo: wordSetView.trailingAnchor, constant: -5),
            addedWordTableView.topAnchor.constraint(equalTo: tableLabel.bottomAnchor, constant: 5),
            addedWordTableView.bottomAnchor.constraint(equalTo: wordSetView.bottomAnchor, constant: -15)
        ])
    }
    
    // MARK: - Button actions
    
    @objc private func addWordButtonTapped() {
        router?.routeToAddWordScene(viewController: self)
    }
    
    @objc private func saveButtonTapped() {
        if let setName = nameView.enteredInfo, !setName.isEmpty,
            let setEmoji = emojiView.enteredInfo, !setEmoji.isEmpty, !addedWords.isEmpty {
            interactor?.saveWordSetInCoreData(name: setName, emoji: setEmoji, words: addedWords)
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension AddSetViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource protocol
extension AddSetViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddWordTableViewCell {
            cell.viewModel = addedWords[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - AddWordToSetDataStore protocol
extension AddSetViewController: AddWordToSetDataStore {
    func addWordToArray(word: WordModel) {
        addedWords.append(word)
    }
}

// MARK: - AddSetSavedNotification protocol
extension AddSetViewController: AddSetSavedNotification {
    func showSavedAlert(name: String, emoji: String) {
        let savedAlert = UIAlertController(title: "Saved", message: "Set \(name) \(emoji) was saved!", preferredStyle: .alert)
        savedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(savedAlert, animated: true) {
            self.addedWords = []
            self.nameView.emptyEnteredInfo()
            self.emojiView.emptyEnteredInfo()
        }
    }
}
