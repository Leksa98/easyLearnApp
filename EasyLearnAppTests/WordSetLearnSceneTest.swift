//
//  WordSetLearnSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class WordSetLearnPresentationLogicSpy: WordSetLearnPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    var words: [WordModel]?
    
    func prepareForPresent(response: WordSetLearnModel.FetchWordSet.Response) {
        isCalledPrepareForPresent = true
        words = response.wordsArray
    }
}

final class WordSetLearnWorkingLogicSpy: DataStorageWordSetView, DataStorageWordSetProgress {
    
    private(set) var isCalledFetchWords = false
    private(set) var isCalledUpdateWordProgress = false
    
    let words = [WordModel(word: "study", translation: "учиться"),
                 WordModel(word: "book", translation: "книга")]
    
    
    func fetchWords(from setWithName: String) -> [WordModel] {
        isCalledFetchWords = true
        return words
    }
    
    func updateWordProgress(setName: String, wordUpdate: String, progressChange: Double) {
        isCalledUpdateWordProgress = true
    }
}


final class WordSetLearnSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WordSetLearnInteractor!
    private var worker: WordSetLearnWorkingLogicSpy!
    private var presenter: WordSetLearnPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = WordSetLearnInteractor()
        let wordSetListWorker = WordSetLearnWorkingLogicSpy()
        let wordSetListPresenter = WordSetLearnPresentationLogicSpy()
        
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
        let request = WordSetLearnModel.FetchWordSet.Request(setName: "setName")
        sut.fetchWords(request: request)
        
        XCTAssertTrue(worker.isCalledFetchWords, "Not started worker.fetchWords(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertEqual(worker.words.count, presenter.words?.count)
    }
    
    func testUpdateWordProgress() {
        let request = WordSetLearnModel.EditWordProgress.Request(setName: "setName", word: "word", progressChange: 0.1)
        
        sut.editWordProgress(request: request)
        XCTAssertTrue(worker.isCalledUpdateWordProgress, "Not started worker.updateWordProgress(:)")
    }
}
