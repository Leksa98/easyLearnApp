//
//  ViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.06.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

final class AddSetViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let borderColor = UIColor(cgColor: CGColor(srgbRed: 84.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 1)).cgColor
        static let viewColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        static let textFieldColor = UIColor(cgColor: CGColor(srgbRed: 196.0/255.0, green: 198.0/255.0, blue: 212.0/255.0, alpha: 1))
        static let placeholderColor = UIColor(cgColor: CGColor(srgbRed: 112.0/255.0, green: 99.0/255.0, blue: 134.0/255.0, alpha: 1))
        static let cellID = "cell"
        static let cellSize = CGSize(width: 100, height: 100)
    }
    
    // MARK: - Properties
    
    private var addWordButton = ButtonWithRoundCorners(title: "Add word")
    private var nameView = UIView()
    private var emojiView = UIView()
    private var enterInformationStack = UIStackView()
    private var nameLabel = UILabel()
    private var enterNameTextField = UITextField()
    private var emojiLabel = UILabel()
    private var enterEmojiTextField = UITextField()
    private var wordSetView = UIView()
    private var addedWordTableView = UITableView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        dismissKey()
        configureNameView()
        configureEmojiView()
        configuteTableView()
        setAddButton()
    }
    
    // MARK: - Configuration
    
    private func configureView() {
        title = "Add new set"
        view.backgroundColor = Locals.backgroundColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = Locals.buttonColor
    }
    
    private func setAddButton() {
        addWordButton.addTarget(self, action: #selector(addWordButtonTapped), for: .touchUpInside)
        view.addSubview(addWordButton)
        addWordButton.backgroundColor = Locals.buttonColor
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
        emojiView.backgroundColor = Locals.viewColor
        emojiView.layer.borderWidth = 2
        emojiView.layer.borderColor = Locals.borderColor
        emojiView.layer.cornerRadius = 15
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.addSubview(emojiLabel)
        emojiView.addSubview(enterEmojiTextField)
        emojiLabel.text = "Set Emoji"
        emojiLabel.font = .boldSystemFont(ofSize: 20)
        enterEmojiTextField.attributedPlaceholder = NSAttributedString(string: "Enter set emoji", attributes: [NSAttributedString.Key.foregroundColor: Locals.placeholderColor, NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 18)])
        enterEmojiTextField.font = .systemFont(ofSize: 18)
        enterEmojiTextField.textColor = .black
        enterEmojiTextField.layer.cornerRadius = 6.0
        enterEmojiTextField.layer.masksToBounds = true
        enterEmojiTextField.borderStyle = .roundedRect
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        enterEmojiTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emojiView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            emojiView.heightAnchor.constraint(equalToConstant: 100),
            emojiLabel.leadingAnchor.constraint(equalTo: emojiView.leadingAnchor, constant: 15),
            emojiLabel.trailingAnchor.constraint(equalTo: emojiView.trailingAnchor, constant: -15),
            emojiLabel.topAnchor.constraint(equalTo: emojiView.topAnchor, constant: 15),
            enterEmojiTextField.leadingAnchor.constraint(equalTo: emojiView.leadingAnchor, constant: 15),
            enterEmojiTextField.trailingAnchor.constraint(equalTo: emojiView.trailingAnchor, constant: -15),
            enterEmojiTextField.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 10),
            enterEmojiTextField.bottomAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: -15)
        ])
    }
    
    private func configureNameView() {
        view.addSubview(nameView)
        nameView.backgroundColor = Locals.viewColor
        nameView.layer.borderWidth = 2
        nameView.layer.borderColor = Locals.borderColor
        nameView.layer.cornerRadius = 15
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.addSubview(nameLabel)
        nameView.addSubview(enterNameTextField)
        nameLabel.text = "Set Title"
        enterNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter set title", attributes: [NSAttributedString.Key.foregroundColor: Locals.placeholderColor, NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 18)])
        enterNameTextField.font = .systemFont(ofSize: 18)
        enterNameTextField.backgroundColor = Locals.textFieldColor
        enterNameTextField.textColor = .black
        enterEmojiTextField.backgroundColor = Locals.textFieldColor
        enterNameTextField.layer.cornerRadius = 6.0
        enterNameTextField.layer.masksToBounds = true
        enterNameTextField.borderStyle = .roundedRect
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        enterNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameView.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 15),
            enterNameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 15),
            enterNameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor, constant: -15),
            enterNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            enterNameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -15)
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
        addedWordTableView.register(AddWordTableViewCell.self, forCellReuseIdentifier: "addWordTableViewCell")
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
    
    @objc private func addWordButtonTapped() {
        present(AddWordViewController(), animated: true, completion: nil)
    }
    
    private var data = ["Word 1", "Word 2", "Word 3", "Word 4", "Word 5"]
}


extension AddSetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addWordTableViewCell", for: indexPath) as? AddWordTableViewCell {
            cell.viewModel = data[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
