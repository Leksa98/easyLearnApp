//
//  AddSetSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class AddSetPresentationLogicSpy: AddSetPresentationLogic {
   
    private(set) var isCalledPrepareForPresent = false
    
    var isAlreadyExist: Bool?
    
     func prepareForPresent(response: AddSetModel.SaveWordSet.Response) {
        isCalledPrepareForPresent = true
        isAlreadyExist = response.isAlreadyExist
    }
}

final class AddSetWorkingLogicSpy: DataStorageWordSetEdit, DataStorageWordSetSave {
    
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


final class AddSetSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: AddSetInteractor!
    private var worker: AddSetWorkingLogicSpy!
    private var presenter: AddSetPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordSetListInteractor = AddSetInteractor()
        let wordSetListWorker = AddSetWorkingLogicSpy()
        let wordSetListPresenter = AddSetPresentationLogicSpy()
        
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
        
        let request = AddSetModel.SaveWordSet.Request(name: "name", emoji: "emoji", words: words)
        worker.isAbleToSave = true
        sut.saveWordSetInCoreData(request: request)
        
        XCTAssertTrue(worker.isCalledSaveWordSet, "Not started worker.addWordtoSet(:)")
        XCTAssertTrue(worker.isCalledAddWordToSet, "Not started worker.saveWordSet(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertNotEqual(presenter.isAlreadyExist, worker.isAbleToSave)
        
        worker.isAbleToSave = false
        sut.saveWordSetInCoreData(request: request)
        XCTAssertTrue(worker.isCalledSaveWordSet, "Not started worker.addWordtoSet(:)")
        XCTAssertTrue(worker.isCalledAddWordToSet, "Not started worker.saveWordSet(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
        XCTAssertNotEqual(presenter.isAlreadyExist, worker.isAbleToSave)
    }
}
