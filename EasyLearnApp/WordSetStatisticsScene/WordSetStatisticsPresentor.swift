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
    private var sections = [WordStatisticsSection(name: "Know well🏆", words: []),
                            WordStatisticsSection(name: "In progress🚀", words: []),
                            WordStatisticsSection(name: "Don't know‼️", words: [])]
    
    func prepareForPresent(wordDictionary: [WordModel]) {
        var wordsForSection: [WordModel] = []
        for (index,item) in sections.enumerated() {
            switch index {
            case 2:
                wordsForSection = wordDictionary.filter{ $0.progress <= 0.0 }
            case 1:
                wordsForSection = wordDictionary.filter{ $0.progress > 0.0 && $0.progress < 1.0 }
            case 0:
                wordsForSection = wordDictionary.filter{ $0.progress >= 1.0 }
            default:
                print("Error in WordSetStatisticsPresentor")
            }
            wordsForSection.forEach{ word in
                item.appendWord(word: word)
            }
        }
        viewController?.showStatistics(sections: sections)
    }
}
