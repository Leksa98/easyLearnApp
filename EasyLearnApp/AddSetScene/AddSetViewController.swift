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
    func showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel)
    var needToEmptyEnteredInfo: Bool? { get set }
}

final class AddSetViewController: UIViewController {

    // MARK: - Constants
    
    private enum Locals {
        static let cellId = "addSetTableViewCell"
        static let tableViewRowHeight: CGFloat = 44
        static let tableLabelSize: CGFloat = 18
        
        static let leadingAnchor: CGFloat = 15
        static let trailingAnchor: CGFloat = -15
        static let buttonTopAnchor: CGFloat = 10
        static let buttonBottomAnchor: CGFloat = -10
        
        static let infoViewTopAnchor: CGFloat = 10
        static let infoViewHeightAnchor: CGFloat = 100
        
        static let tableLabelTopAnchor: CGFloat = 25
        static let tableViewLeadingAnchor: CGFloat = 5
        static let tableViewTrailingAnchor: CGFloat = -5
        static let tableViewTopAnchor: CGFloat = 5
        
        static let alertViewWidth: CGFloat = 300
        static let alertViewHeight: CGFloat = 150
        static let alertTransformScale: CGFloat = 1.3
        static let animationDuration: TimeInterval = 0.4
    }
    
    // MARK: - Properties
    
    private var addWordButton = ButtonWithRoundCorners(title: "Add word")
    private var nameView = EnterInfoView(label: "Set Title", textField: "Enter set title")
    private var emojiView = EnterInfoView(label: "Set Emoji", textField: "Enter set emoji")
    private var tableView = UITableView()
    private var addedWords: [WordModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let alertView = CustomAlertView()
    private let screenshotImageView = UIImageView()
    var needToEmptyEnteredInfo: Bool?
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
        screenshotImageView.addBlur()
    }
    
    // MARK: - Setup UI elements
    
    private func configureView() {
        title = "Add new set"
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.blueSapphire
    }
    
    private func setAddButton() {
        addWordButton.addTarget(self, action: #selector(addWordButtonTapped), for: .touchUpInside)
        view.addSubview(addWordButton)
        addWordButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                addWordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                addWordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                addWordButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Locals.buttonTopAnchor),
                addWordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Locals.buttonBottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                addWordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
                addWordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
                addWordButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Locals.buttonTopAnchor),
                addWordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Locals.buttonBottomAnchor)
            ])
        }
    }
    
    private func configureEmojiView() {
        view.addSubview(emojiView)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emojiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emojiView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: Locals.infoViewTopAnchor),
            emojiView.heightAnchor.constraint(equalToConstant: Locals.infoViewHeightAnchor)
        ])
    }
    
    private func configureNameView() {
        view.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.infoViewTopAnchor),
                nameView.heightAnchor.constraint(equalToConstant: Locals.infoViewHeightAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                nameView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Locals.infoViewTopAnchor),
                nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                nameView.heightAnchor.constraint(equalToConstant: Locals.infoViewHeightAnchor)
            ])
        }
    }
    
    private func configuteTableView() {
        view.addSubview(tableView)
        let tableLabel = UILabel()
        tableLabel.text = "Added words"
        tableLabel.font = UIFont.sfProTextHeavy(ofSize: Locals.tableLabelSize)
        view.addSubview(tableLabel)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddSetTableViewCell.self, forCellReuseIdentifier: Locals.cellId)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            tableLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            tableLabel.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: Locals.tableLabelTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.tableViewLeadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.tableViewTrailingAnchor),
            tableView.topAnchor.constraint(equalTo: tableLabel.bottomAnchor, constant: Locals.tableViewTopAnchor)
        ])
        if #available(iOS 11.0, *) {} else {
            tableView.estimatedRowHeight = Locals.tableViewRowHeight
        }
    }
    
    // MARK: - Button actions
    
    @objc private func addWordButtonTapped() {
        router?.routeToAddWordScene(viewController: self)
    }
    
    @objc private func saveButtonTapped() {
        screenshotImageView.image = UIApplication.shared.takeScreenshot()
        if let setName = nameView.enteredInfo, !setName.isEmpty,
            let setEmoji = emojiView.enteredInfo, !setEmoji.isEmpty, !addedWords.isEmpty {
            interactor?.saveWordSetInCoreData(request: AddSetModel.SaveWordSet.Request(name: setName, emoji: setEmoji, words: addedWords))
        } else {
            needToEmptyEnteredInfo = false
            showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel(alertTitleLabel: "Not saved!", alertMessageLabel: "You entered not all information!"))
        }
    }
}

// MARK: - UITableViewDelegate protocol
extension AddSetViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource protocol
extension AddSetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addedWords.count == 0 {
            tableView.backgroundView = AddSetTableEmptyView()
        } else {
            tableView.backgroundView = nil
        }
        return addedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellId, for: indexPath) as? AddSetTableViewCell {
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
    func showSavedAlert(viewModel: AddSetModel.SaveWordSet.ViewModel) {
        alertView.alpha = 0
        alertView.titleLabel.text = viewModel.alertTitleLabel
        alertView.messageLabel.text = viewModel.alertMessageLabel
        alertView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(screenshotImageView)
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenshotImageView.topAnchor.constraint(equalTo: view.topAnchor),
            screenshotImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            screenshotImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenshotImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: Locals.alertViewWidth),
            alertView.heightAnchor.constraint(equalToConstant: Locals.alertViewHeight),
        ])
        alertView.transform = CGAffineTransform(scaleX: Locals.alertTransformScale, y: Locals.alertTransformScale)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIView.animate(withDuration: Locals.animationDuration) {
            self.visualEffectView.alpha = 0.7
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: Locals.animationDuration,
                       animations: {
                        self.visualEffectView.alpha = 0
                        self.alertView.alpha = 0
                        self.alertView.transform = CGAffineTransform(scaleX: Locals.alertTransformScale, y: Locals.alertTransformScale)
        }) { _ in
            if let needToEmptyEnteredInfo = self.needToEmptyEnteredInfo, needToEmptyEnteredInfo {
                self.addedWords = []
                self.nameView.emptyEnteredInfo()
                self.emojiView.emptyEnteredInfo()
            }
            self.alertView.removeFromSuperview()
            self.screenshotImageView.removeFromSuperview()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}
