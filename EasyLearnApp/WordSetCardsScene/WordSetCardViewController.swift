//
//  WordSetCardsViewController.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 29.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetCardsShow: class {
    func loadWordSetCards(viewModel: WordSetCardModel.FetchWordSet.ViewModel)
}

final class WordSetCardViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Locals {
        static let cellID = "WordSetCardsCellId"
        static let lineSpacing = CGFloat(100)
        static let edgeInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let numberOfSections = 1
        static let topAnchor: CGFloat = 10
        static let leadingAnchor: CGFloat = 10
        static let trailingAnchor: CGFloat = -10
        static let bottomAnchor: CGFloat = -100
        static let buttonHeight: CGFloat = 35
        static let buttonWidth: CGFloat = 165
        static let animationDuration: TimeInterval = 0.5
        static let scrollingConstant: CGFloat = 80
        static let cardSizeOffset: CGFloat = 20
    }
    
    // MARK: - Property
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var nextCardButton = ButtonWithRoundCorners(title: "Next")
    private var prevCardButton = ButtonWithRoundCorners(title: "Previous")
    private var setName: String?
    private var wordSetArray: [WordModel] = [] {
        willSet {
            if newValue.count == 1 {
                prevCardButton.isHidden = true
                nextCardButton.setTitle("Done", for: .normal)
                UIView.animate(withDuration: Locals.animationDuration, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations:  {
                    self.nextCardButton.backgroundColor = .customGreen
                    self.nextCardButton.removeTarget(self, action: #selector(self.nextCardButtonTapped), for: .touchUpInside)
                    self.nextCardButton.addTarget(self, action: #selector(self.dismissViewController), for: .touchUpInside)
                }, completion: { _ in
                    self.nextCardButton.layer.removeAllAnimations()
                })
            }
        }
        didSet {
            collectionView.reloadData()
        }
    }
    var interactor: WordSetCardBusinessLogic?
    var router: WordSetCardRouterLogic?
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissViewController))
        title = "Cards"
        view.backgroundColor = .white
        configureCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(WordSetCardCollectionViewCell.self, forCellWithReuseIdentifier: Locals.cellID)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        configureNextCardButton()
        configurePrevCardButton()
    }
    
    // MARK: - Setup UI elements
    
    private func configureCollectionView() {
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Locals.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: Locals.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Locals.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: Locals.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    private func configureNextCardButton() {
        nextCardButton.addTarget(self, action: #selector(nextCardButtonTapped), for: .touchUpInside)
        view.addSubview(nextCardButton)
        nextCardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextCardButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Locals.topAnchor),
            nextCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Locals.trailingAnchor),
            nextCardButton.heightAnchor.constraint(equalToConstant: Locals.buttonHeight),
            nextCardButton.widthAnchor.constraint(equalToConstant: Locals.buttonWidth)
        ])
    }
    
    private func configurePrevCardButton() {
        prevCardButton.addTarget(self, action: #selector(prevCardButtonTapped), for: .touchUpInside)
        view.addSubview(prevCardButton)
        prevCardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prevCardButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Locals.topAnchor),
            prevCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.leadingAnchor),
            prevCardButton.heightAnchor.constraint(equalToConstant: Locals.buttonHeight),
            prevCardButton.widthAnchor.constraint(equalToConstant: Locals.buttonWidth)
        ])
        prevCardButton.isHidden = true
    }
    
    // MARK: - Button actions
    
    @objc private func nextCardButtonTapped() {
        prevCardButton.isHidden = false
        let scrollCollectionViewWidth = wordSetArray.count * (Int(collectionView.frame.size.width) + Int(Locals.scrollingConstant))
        
        if  Int(collectionView.contentOffset.x + collectionView.frame.size.width) + Int(Locals.scrollingConstant) < scrollCollectionViewWidth {
            UIView.animate(withDuration: Locals.animationDuration) {
                self.collectionView.contentOffset.x += self.collectionView.frame.size.width + Locals.scrollingConstant
            }
        }
        
        if Int(collectionView.contentOffset.x + collectionView.frame.size.width) + Int(Locals.scrollingConstant) == scrollCollectionViewWidth {
            UIView.animate(withDuration: Locals.animationDuration, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations:  {
                self.nextCardButton.setTitle("Done", for: .normal)
                self.nextCardButton.backgroundColor = .customGreen
                self.nextCardButton.removeTarget(self, action: #selector(self.nextCardButtonTapped), for: .touchUpInside)
                self.nextCardButton.addTarget(self, action: #selector(self.dismissViewController), for: .touchUpInside)
            }, completion: { _ in
                self.nextCardButton.layer.removeAllAnimations()
            })
        }
    }

    @objc private func prevCardButtonTapped() {
        nextCardButton.isHidden = false
        if collectionView.contentOffset.x - (collectionView.frame.size.width + Locals.scrollingConstant) >= 0 {
            UIView.animate(withDuration: Locals.animationDuration) {
                self.collectionView.contentOffset.x -= self.collectionView.frame.size.width + Locals.scrollingConstant
                if self.nextCardButton.titleLabel?.text == "Done" {
                    self.nextCardButton.layer.removeAllAnimations()
                    self.nextCardButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.nextCardButton.setTitle("Next", for: .normal)
                    self.nextCardButton.backgroundColor = .blueSapphire
                    self.nextCardButton.removeTarget(self, action: #selector(self.dismissViewController), for: .touchUpInside)
                    self.nextCardButton.addTarget(self, action: #selector(self.nextCardButtonTapped), for: .touchUpInside)
                }
            }
        }
        if collectionView.contentOffset.x == 0 {
            prevCardButton.isHidden = true
        }
    }
    
    @objc private func dismissViewController() {
        router?.routeBack()
    }
}

// MARK: - UICollectionViewDelegate protocol
extension WordSetCardViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource protocol
extension WordSetCardViewController: UICollectionViewDataSource {
    
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

// MARK: - UICollectionViewDelegateFlowLayout protocol
extension WordSetCardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - Locals.cardSizeOffset, height: collectionView.frame.size.width - Locals.cardSizeOffset)
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

// MARK: - WordSetCardsShow protocol
extension WordSetCardViewController: WordSetCardsShow {
    
    func loadWordSetCards(viewModel: WordSetCardModel.FetchWordSet.ViewModel) {
        wordSetArray = viewModel.wordsArray
    }
}
