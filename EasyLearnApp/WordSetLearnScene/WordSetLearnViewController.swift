//
//  WordSetLearnViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 30.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetLearnShow: class {
    func showWords(words: [WordModel])
}

protocol WordSetLearnDataSource {
    var setName: String? { get set }
}

final class WordSetLearnViewController: UIViewController, WordSetLearnDataSource {
    
    // MARK: - Constants
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let cellId = "WordSetLearnCellId"
        static let cellSize = CGSize(width: 300, height: 300)
        static let lineSpacing = CGFloat(100)
        static let edgeInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let numberOfSections = 1
    }
    
    // MARK: - Property
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var checkButton = ButtonWithRoundCorners(title: "Check")
    var wordsToLearn: [WordModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var interactor: WordSetLearnBusinessLogic?
    var setName: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Learn"
        view.backgroundColor = Locals.backgroundColor
        
        configureCollectionView()
        configureCheckButton()
        
        let interactor = WordSetLearnInteractor()
        self.interactor = interactor
        let presentor = WordSetLearnPresentor()
        interactor.presenter = presentor
        presentor.viewController = self
        if let setName = setName {
            interactor.fetchWords(setName: setName)
        }
    }
    
    // MARK: - Configuration
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -320),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Locals.backgroundColor
        collectionView.register(WordSetLearnCollectionViewCell.self, forCellWithReuseIdentifier: Locals.cellId)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    private func configureCheckButton() {
        view.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            checkButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            checkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func checkButtonTapped() {
        let scrollCollectionViewWidth = wordsToLearn.count * (Int(collectionView.frame.size.width) + 80)
        if  Int(collectionView.contentOffset.x + collectionView.frame.size.width) + 80 < scrollCollectionViewWidth {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.x += self.collectionView.frame.size.width + 80
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension WordSetLearnViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource
extension WordSetLearnViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordsToLearn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Locals.cellId, for: indexPath) as? WordSetLearnCollectionViewCell {
            cell.viewModel = wordsToLearn[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WordSetLearnViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width / 2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Locals.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Locals.edgeInserts
    }
}

// MARK: - WordSetLearnShow
extension WordSetLearnViewController: WordSetLearnShow {
    func showWords(words: [WordModel]) {
        wordsToLearn = words
    }
}
