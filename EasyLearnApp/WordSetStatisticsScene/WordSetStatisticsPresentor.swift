//
//  WordSetStatisticsPresentor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetStatisticsPresentationLogic {
    func prepareForPresent(wordDictionary: [WordModel])
}

final class WordSetStatisticsPresentor: WordSetStatisticsPresentationLogic {
    
    weak var viewController: WordSetStatisticsShow?
    private var nameSections = ["Know well🏆", "In progress🚀", "Don't know‼️"]
    
    func prepareForPresent(wordDictionary: [WordModel]) {
        var sections: [WordStatisticsSection] = []
        for item in nameSections {
            sections.append(WordStatisticsSection(name: item, words: []))
        }
        viewController?.showStatistics(sections: sections)
    }
}
