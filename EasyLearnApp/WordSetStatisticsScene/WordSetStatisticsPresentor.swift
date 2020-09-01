//
//  WordSetStatisticsPresentor.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 04.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

protocol WordSetStatisticsPresentationLogic {
    func prepareForPresent(response: WordSetStatisticsModel.FetchWordSet.Response)
}

final class WordSetStatisticsPresentor: WordSetStatisticsPresentationLogic {
    
    weak var viewController: WordSetStatisticsShow?
    private var sections = [WordStatisticsSectionModel(name:
        NSLocalizedString("progress_well_known_section", comment: ""), words: []),
                            WordStatisticsSectionModel(name:
                                NSLocalizedString("progress_in_progress_section", comment: ""), words: []),
                            WordStatisticsSectionModel(name: NSLocalizedString("progress_do_not_know_section", comment: ""), words: [])]
    
    func prepareForPresent(response: WordSetStatisticsModel.FetchWordSet.Response) {
        var wordsForSection: [WordModel] = []
        for (index,item) in sections.enumerated() {
            switch index {
            case 2:
                wordsForSection = response.wordsArray.filter{ $0.progress <= 0.0 }
            case 1:
                wordsForSection = response.wordsArray.filter{ $0.progress > 0.0 && $0.progress < 1.0 }
            case 0:
                wordsForSection = response.wordsArray.filter{ $0.progress >= 1.0 }
            default:
                print("Error in WordSetStatisticsPresentor")
            }
            wordsForSection.forEach{ word in
                item.appendWord(word: word)
            }
        }
        viewController?.showStatistics(viewModel: WordSetStatisticsModel.FetchWordSet.ViewModel(sections: sections))
    }
}
