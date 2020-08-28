//
//  DefaultWordSetListSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class DefaultWordSetListPresentationLogicSpy: DefaultWordSetListPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    
    var isResponseNil: Bool?
    
    func prepareForPresent(response: DefaultWordSetListModel.DownloadWordSet.Response?) {
        isCalledPrepareForPresent = true
        if response != nil {
            isResponseNil = false
        } else {
            isResponseNil = true
        }
    }
}

final class DefaultWordSetListWorkingLogicSpy: DataStorageWordSetEdit, DataStorageWordSetSave {
    
    private(set) var isCalledAddWordToSet = false
    private(set) var isCalledSaveWordSet = false
    
    var isAbleToSave = true
    
    func addWordtoSet(name: String, word: String, translation: String) {
        isCalledAddWordToSet = true
    }
    
    func saveWordSet(name: String, emoji: String) -> Bool {
        isCalledSaveWordSet = true
        return isAbleToSave
    }
    
    func deleteWordfromSet(name: String, wordValue: String) { }
}


final class DefaultWordSetListSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: DefaultWordSetListInteractor!
    private var worker: DefaultWordSetListWorkingLogicSpy!
    private var presenter: DefaultWordSetListPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = DefaultWordSetListInteractor()
        let wordSetListWorker = DefaultWordSetListWorkingLogicSpy()
        let wordSetListPresenter = DefaultWordSetListPresentationLogicSpy()
        
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
        let words = [WordModel(word: "study", translation: "учиться"),
        WordModel(word: "book", translation: "книга")]
        
        let request = DefaultWordSetListModel.DownloadWordSet.Request(name: "name", emoji: "emoji", words: words)
        worker.isAbleToSave = true
        sut.downloadWordSet(request: request)
        
        XCTAssertTrue(worker.isCalledSaveWordSet, "Not started worker.addWordtoSet(:)")
        XCTAssertTrue(worker.isCalledAddWordToSet, "Not started worker.saveWordSet(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertNotEqual(presenter.isResponseNil, worker.isAbleToSave)
        
        worker.isAbleToSave = false
        sut.downloadWordSet(request: request)
        XCTAssertTrue(worker.isCalledSaveWordSet, "Not started worker.addWordtoSet(:)")
        XCTAssertTrue(worker.isCalledAddWordToSet, "Not started worker.saveWordSet(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertNotEqual(presenter.isResponseNil, worker.isAbleToSave)
    }
}
