//
//  WordSetRouter.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit

protocol WordSetRouterLogic {
    var navigationController: UINavigationController? { get }
    func routeToWordSetList(with title: String)
    func routeToWordSetCards(with title: String)
    func routeToWordSetLearn(with title: String)
    func routeToWordSetStatistics(with title: String)
}

final class WordSetRouter: WordSetRouterLogic {
    
    weak var navigationController: UINavigationController?
    
    func routeToWordSetList(with title: String) {
        let viewController = WordListViewController()
        WordSetListConfigurator.assembly(viewController: viewController, setTitle: title)
        viewController.interactor?.fetchWordSet(request: WordSetListModel.FetchWordSet.Request(setName: title))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func routeToWordSetCards(with title: String) {
        let viewController = WordSetCardViewController()
        navigationController?.pushViewController(viewController, animated: true)
        WordSetCardConfigurator.assembly(viewController: viewController)
        viewController.title = title
        viewController.interactor?.fetchWordSet(request: WordSetCardModel.FetchWordSet.Request(setName: title))
    }
    
    func routeToWordSetLearn(with title: String) {
        let viewController = WordSetLearnViewController()
        navigationController?.pushViewController(viewController, animated: true)
        WordSetLearnConfigurator.assembly(viewController: viewController)
        viewController.title = title
        viewController.interactor?.fetchWords(request: WordSetLearnModel.FetchWordSet.Request(setName: title))
    }
    
    func routeToWordSetStatistics(with title: String) {
        let viewController = WordSetStatisticsConfigurator.assembly(setTitle: title)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
