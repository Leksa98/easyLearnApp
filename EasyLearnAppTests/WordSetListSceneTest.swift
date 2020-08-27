//
//  WordSetListSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 27.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class WordSetListPresentationLogicSpy: WordSetListPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    var words: [WordModel]?
    
    func prepareForPresent(response: WordSetListModel.FetchWordSet.Response) {
        isCalledPrepareForPresent = true
        words = response.words
    }
}

final class WordSetListWorkingLogicSpy: DataStorageWordSetEdit, DataStorageWordSetView {
    
    private(set) var isCalledAddWordtoSet = false
    private(set) var isCalledDeleteWordfromSet = false
    private(set) var isCalledFetchWords = false
    
    let words = [WordModel(word: "study", translation: "учиться"),
                 WordModel(word: "book", translation: "книга")]
    
    func addWordtoSet(name: String, word: String, translation: String) {
        isCalledAddWordtoSet = true
    }
    
    func deleteWordfromSet(name: String, wordValue: String) {
        isCalledDeleteWordfromSet = true
    }
    
    func fetchWords(from setWithName: String) -> [WordModel] {
        isCalledFetchWords = true
        return words
    }
}

final class WordSetListSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WordSetListInteractor!
    private var worker: WordSetListWorkingLogicSpy!
    private var presenter: WordSetListPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = WordSetListInteractor()
        let wordSetListWorker = WordSetListWorkingLogicSpy()
        let wordSetListPresenter = WordSetListPresentationLogicSpy()
        
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
        let request = WordSetListModel.FetchWordSet.Request(setName: "setName")
        sut.fetchWordSet(request: request)
        
        XCTAssertTrue(worker.isCalledFetchWords, "Not started worker.fetchWords(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertEqual(worker.words.count, presenter.words?.count)
    }
    
    func testAddWordToSet() {
        let request =  WordSetListModel.AddWordToSet.Request(setName: "setName", word: WordModel(word: "word", translation: "translation"))
        sut.addWordToSet(request: request)
        XCTAssertTrue(worker.isCalledAddWordtoSet, "Not started worker.addWordtoSet(:)")
    }
    
    func testDeleteWordfromSet() {
        let request =  WordSetListModel.DeleteWordFromSet.Request(set: "set", word: "word")
        sut.deleteWordFromSet(request: request)
        XCTAssertTrue(worker.isCalledDeleteWordfromSet, "Not started worker.deleteWordfromSet(:)")
    }
}
