//
//  WordSetStatisticsSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class WordSetStatisticsPresentationLogicSpy: WordSetStatisticsPresentationLogic {
   
    private(set) var isCalledPrepareForPresent = false
    var words: [WordModel]?
    
     func prepareForPresent(response: WordSetStatisticsModel.FetchWordSet.Response) {
        isCalledPrepareForPresent = true
        words = response.wordsArray
    }
}

final class WordSetStatisticsWorkingLogicSpy: DataStorageWordSetView {
    
    private(set) var isCalledFetchWords = false
    
    let words = [WordModel(word: "study", translation: "учиться"),
                 WordModel(word: "book", translation: "книга")]
    
    
    func fetchWords(from setWithName: String) -> [WordModel] {
        isCalledFetchWords = true
        return words
    }
}


final class WordSetStatisticsSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WordSetStatisticsInteractor!
    private var worker: WordSetStatisticsWorkingLogicSpy!
    private var presenter: WordSetStatisticsPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = WordSetStatisticsInteractor()
        let wordSetListWorker = WordSetStatisticsWorkingLogicSpy()
        let wordSetListPresenter = WordSetStatisticsPresentationLogicSpy()
        
        wordSetListInteractor.worker = wordSetListWorker
        wordSetListInteractor.presenter = wordSetListPresenter
        
        sut = wordSetListInteractor
        worker = wordSetListWorker
        presenter = wordSetListPresenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchWordSet() {
        let request = WordSetStatisticsModel.FetchWordSet.Request(setName: "setName")
        sut.fetchWords(request: request)
        
        XCTAssertTrue(worker.isCalledFetchWords, "Not started worker.fetchWords(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertEqual(worker.words.count, presenter.words?.count)
    }
}
