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
        let vc = WordListTableViewController()
        WordSetListConfigurator.assembly(viewController: vc, setTitle: title)
        vc.interactor?.fetchWordSet(request: WordSetListModel.FetchWordSet.Request(setName: title))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToWordSetCards(with title: String) {
        let vc = WordSetCardsConfigurator.assembly()
        vc.title = title
        vc.interactor?.fetchWordSet(setName: title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToWordSetLearn(with title: String) {
        let vc = WordSetLearnConfigurator.assembly()
        vc.title = title
        vc.interactor?.fetchWords(setName: title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToWordSetStatistics(with title: String) {
        let vc = WordSetStatisticsConfigurator.assembly(setTitle: title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
