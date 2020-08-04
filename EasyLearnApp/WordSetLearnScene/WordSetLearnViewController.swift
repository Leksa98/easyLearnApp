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
    private var helpButton = ButtonWithRoundCorners(title: "Don't know")
    private var buttonStackView = UIStackView()
    
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
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissViewController))
        title = "Learn"
        view.backgroundColor = Locals.backgroundColor
        
        configureCollectionView()
        configureButtonStackView()
        
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
        collectionView.isScrollEnabled = false
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
    
    private func configureButtonStackView() {
        buttonStackView.addArrangedSubview(helpButton)
        helpButton.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
        buttonStackView.addArrangedSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func checkButtonTapped() {
        if let currentCellIndexPath = getCurrentCellIndexPath(), let cell = collectionView.cellForItem(at: currentCellIndexPath) as? WordSetLearnCollectionViewCell {
            if cell.checkExercise() {
                cell.showAnimation(correctAnswer: true) { finished in
                    self.scrollCollectionViewToNextExercise()
                }
            } else {
                cell.showAnimation(correctAnswer: false)
            }
        }
    }
    
    @objc private func helpButtonTapped() {
        if let currentCellIndexPath = getCurrentCellIndexPath(), let cell = collectionView.cellForItem(at: currentCellIndexPath) as? WordSetLearnCollectionViewCell {
            cell.showHelpAnimation()
        }
    }
    
    private func scrollCollectionViewToNextExercise() {
        let scrollCollectionViewWidth = wordsToLearn.count * (Int(collectionView.frame.size.width) + 80)
        if  Int(collectionView.contentOffset.x + collectionView.frame.size.width) + 80 < scrollCollectionViewWidth {
            UIView.animate(withDuration: 0.6) {
                self.collectionView.contentOffset.x += self.collectionView.frame.size.width + 80
            }
        } else {
            let finishedExerciseAlert = UIAlertController(title: "Congratulations 🎉🎉🎉", message: "You've just finished exercise!", preferredStyle: .alert)
            finishedExerciseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            present(finishedExerciseAlert, animated: true)
        }
    }
    
    private func getCurrentCellIndexPath() -> IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
    
    @objc private func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate protocol
extension WordSetLearnViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource protocol
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

// MARK: - UICollectionViewDelegateFlowLayout protocol
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

// MARK: - WordSetLearnShow protocol
extension WordSetLearnViewController: WordSetLearnShow {
    func showWords(words: [WordModel]) {
        wordsToLearn = words
    }
}
