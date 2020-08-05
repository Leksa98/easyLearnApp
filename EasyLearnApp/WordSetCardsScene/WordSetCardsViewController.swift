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
        static let viewColor = UIColor(cgColor: CGColor(srgbRed: 233.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1))
        static let borderColor = UIColor(cgColor: CGColor(srgbRed: 84.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 1)).cgColor
        static let cellID = "WordSetCardsCellId"
        static let cellSize = CGSize(width: 300, height: 300)
        static let lineSpacing = CGFloat(100)
        static let edgeInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let numberOfSections = 1
    }
    
    // MARK: - Property
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var nextCardButton = UIButton()
    private var prevCardButton = UIButton()
    private var setName: String?
    private var wordSetArray: [WordModel] = [] {
        willSet {
            if newValue.count == 1 {
                nextCardButton.isHidden = true
                prevCardButton.isHidden = true
            }
        }
        didSet {
            collectionView.reloadData()
        }
    }
    var interactor: WordSetCardBusinessLogic?
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissViewController))
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
        collectionView.isScrollEnabled = false
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
        nextCardButton.setTitle("Next", for: .normal)
        nextCardButton.layer.cornerRadius = 15
        nextCardButton.layer.borderWidth = 2
        nextCardButton.layer.borderColor = Locals.borderColor
        nextCardButton.setTitleColor(.black, for: .normal)
        nextCardButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        nextCardButton.backgroundColor = Locals.viewColor
        nextCardButton.addTarget(self, action: #selector(nextCardButtonTapped), for: .touchUpInside)
        view.addSubview(nextCardButton)
        nextCardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextCardButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            nextCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nextCardButton.heightAnchor.constraint(equalToConstant: 35),
            nextCardButton.widthAnchor.constraint(equalToConstant: 165)
        ])
    }
    
    private func configurePrevCardButton() {
        prevCardButton.setTitle("Previous", for: .normal)
        prevCardButton.layer.cornerRadius = 15
        prevCardButton.layer.borderWidth = 2
        prevCardButton.layer.borderColor = Locals.borderColor
        prevCardButton.setTitleColor(.black, for: .normal)
        prevCardButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        prevCardButton.backgroundColor = Locals.viewColor
        prevCardButton.addTarget(self, action: #selector(prevCardButtonTapped), for: .touchUpInside)
        view.addSubview(prevCardButton)
        prevCardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prevCardButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            prevCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            prevCardButton.heightAnchor.constraint(equalToConstant: 35),
            prevCardButton.widthAnchor.constraint(equalToConstant: 165)
        ])
        prevCardButton.isHidden = true
    }
    
    @objc private func nextCardButtonTapped() {
        prevCardButton.isHidden = false
        let scrollCollectionViewWidth = wordSetArray.count * (Int(collectionView.frame.size.width) + 80)
        
        if  Int(collectionView.contentOffset.x + collectionView.frame.size.width) + 80 < scrollCollectionViewWidth {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.x += self.collectionView.frame.size.width + 80
            }
        }
        
        if Int(collectionView.contentOffset.x + collectionView.frame.size.width) + 80 == scrollCollectionViewWidth {
            nextCardButton.isHidden = true
        }
    }

    @objc private func prevCardButtonTapped() {
        nextCardButton.isHidden = false
        if collectionView.contentOffset.x - (collectionView.frame.size.width + 80) >= 0 {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.x -= self.collectionView.frame.size.width + 80
            }
        }
        if collectionView.contentOffset.x == 0 {
            prevCardButton.isHidden = true
        }
    }
    
    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
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
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width - 20)
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

