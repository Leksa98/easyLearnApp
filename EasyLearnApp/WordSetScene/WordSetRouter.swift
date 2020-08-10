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
        let vc = WordListViewController()
        WordSetListConfigurator.assembly(viewController: vc, setTitle: title)
        vc.interactor?.fetchWordSet(request: WordSetListModel.FetchWordSet.Request(setName: title))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToWordSetCards(with title: String) {
        let vc = WordSetCardViewController()
        navigationController?.pushViewController(vc, animated: true)
        WordSetCardConfigurator.assembly(viewController: vc)
        vc.title = title
        vc.interactor?.fetchWordSet(request: WordSetCardModel.FetchWordSet.Request(setName: title))
    }
    
    func routeToWordSetLearn(with title: String) {
        let vc = WordSetLearnViewController()
        navigationController?.pushViewController(vc, animated: true)
        WordSetLearnConfigurator.assembly(viewController: vc)
        vc.title = title
        vc.interactor?.fetchWords(request: WordSetLearnModel.FetchWordSet.Request(setName: title))
    }
    
    func routeToWordSetStatistics(with title: String) {
        let vc = WordSetStatisticsConfigurator.assembly(setTitle: title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
