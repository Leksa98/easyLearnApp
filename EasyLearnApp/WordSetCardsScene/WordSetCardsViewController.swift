//
//  WordSetCardsViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetCardsShow: class {
    func loadWordSetCards(words: [WordModel])
    func loadSetName(name: String)
}

final class WordSetCardsViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let backgroundColor = UIColor(cgColor: CGColor(srgbRed: 249.0/255.0, green: 248.0/255.0, blue: 241.0/255.0, alpha: 1))
        static let buttonColor = UIColor(cgColor: CGColor(srgbRed: 118.0/255.0, green: 93.0/255.0, blue: 152.0/255.0, alpha: 1))
        static let cellID = "WordSetCardsCellId"
        static let cellSize = CGSize(width: 300, height: 300)
        static let lineSpacing = CGFloat(100)
        static let edgeInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let numberOfSections = 1
    }
    
    // MARK: - Property
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var nextCard = UIButton()
    private var prevCard = UIButton()
    private var setName: String?
    private var wordSetArray: [WordModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var interactor: WordSetCardBusinessLogic?
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards"
        view.backgroundColor = Locals.backgroundColor
        configureCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Locals.backgroundColor
        collectionView.register(WordSetCardCollectionViewCell.self, forCellWithReuseIdentifier: Locals.cellID)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        configureNextCardButton()
        configurePrevCardButton()
    }
    
    // MARK: - Configuration
    
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureNextCardButton() {
        nextCard.setTitle("Next", for: .normal)
        nextCard.layer.cornerRadius = 15
        nextCard.tintColor = .white
        nextCard.titleLabel?.font = .boldSystemFont(ofSize: 18)
        nextCard.backgroundColor = Locals.buttonColor
        nextCard.addTarget(self, action: #selector(nextCardButtonTapped), for: .touchUpInside)
        view.addSubview(nextCard)
        nextCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextCard.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            nextCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextCard.heightAnchor.constraint(equalToConstant: 30),
            nextCard.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configurePrevCardButton() {
        prevCard.setTitle("Previous", for: .normal)
        prevCard.layer.cornerRadius = 15
        prevCard.tintColor = .white
        prevCard.titleLabel?.font = .boldSystemFont(ofSize: 18)
        prevCard.backgroundColor = Locals.buttonColor
        prevCard.addTarget(self, action: #selector(prevCardButtonTapped), for: .touchUpInside)
        view.addSubview(prevCard)
        prevCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prevCard.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            prevCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            prevCard.heightAnchor.constraint(equalToConstant: 30),
            prevCard.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func nextCardButtonTapped() {
        let scrollCollectionViewWidth = wordSetArray.count * (Int(collectionView.frame.size.width) + 80)
        if  Int(collectionView.contentOffset.x + collectionView.frame.size.width) + 80 < scrollCollectionViewWidth {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.x += self.collectionView.frame.size.width + 80
            }
        }
    }

    @objc private func prevCardButtonTapped() {
        if collectionView.contentOffset.x - (collectionView.frame.size.width + 80) >= 0 {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.x -= self.collectionView.frame.size.width + 80
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension WordSetCardsViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource
extension WordSetCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordSetArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Locals.cellID, for: indexPath) as? WordSetCardCollectionViewCell {
            cell.viewModel = wordSetArray[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WordSetCardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 20 , height: collectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Locals.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Locals.edgeInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WordSetCardCollectionViewCell {
            cell.flipCardAnimation()
        }
    }
}

extension WordSetCardsViewController: WordSetCardsShow {
    func loadSetName(name: String) {
        setName = name
        let interactor = WordSetCardInteractor()
        self.interactor = interactor
        let presenter = WordSetCardPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        interactor.fetchWordSet(setName: name)
    }
    
    func loadWordSetCards(words: [WordModel]) {
        wordSetArray = words
    }
}

