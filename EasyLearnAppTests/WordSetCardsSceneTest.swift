//
//  WordSetCardsSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class WordSetCardsPresentationLogicSpy: WordSetCardPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    var words: [WordModel]?
    
    func prepareForPresent(response: WordSetCardModel.FetchWordSet.Response) {
        isCalledPrepareForPresent = true
        words = response.wordsArray
    }
}

final class WordSetCardWorkingLogicSpy: DataStorageWordSetView {
    
    private(set) var isCalledFetchWords = false
    
    let words = [WordModel(word: "study", translation: "учиться"),
                 WordModel(word: "book", translation: "книга")]
    
    
    func fetchWords(from setWithName: String) -> [WordModel] {
        isCalledFetchWords = true
        return words
    }
}


final class WordSetCardsSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WordSetCardInteractor!
    private var worker: WordSetCardWorkingLogicSpy!
    private var presenter: WordSetCardsPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = WordSetCardInteractor()
        let wordSetListWorker = WordSetCardWorkingLogicSpy()
        let wordSetListPresenter = WordSetCardsPresentationLogicSpy()
        
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
        let request = WordSetCardModel.FetchWordSet.Request(setName: "setName")
        sut.fetchWordSet(request: request)
        
        XCTAssertTrue(worker.isCalledFetchWords, "Not started worker.fetchWords(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertEqual(worker.words.count, presenter.words?.count)
    }
}
