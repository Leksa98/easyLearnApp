//
//  WordOfDaySceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 29.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class WordOfDayWorkingLogicSpy: WordOfDayParse {
    
    private(set) var isCalledFetchWordOfDay = false
    var fetchSuccess = true
    
    func fetchWordOfDay(completion: @escaping (WordOfDay?, String?) -> ()) {
        isCalledFetchWordOfDay = true
        if fetchSuccess {
            completion(WordOfDay(word: "word", date: "date", note: "note", definition: [], example: []), nil)
        } else {
            completion(nil, "error")
        }
    }
}

final class WordOfDayPresentationLogicSpy: WordOfDayPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    
    func prepareForPresent(response: WordOfDayModel.FetchWordOfDay.Response) {
        isCalledPrepareForPresent = true
    }
}


final class WordOfDaySceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: WordOfDayInteractor!
    private var worker: WordOfDayWorkingLogicSpy!
    private var presenter: WordOfDayPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let wordOfDayInteractor = WordOfDayInteractor()
        let wordOfDayWorker = WordOfDayWorkingLogicSpy()
        let wordOfDayPresenter = WordOfDayPresentationLogicSpy()
        
        wordOfDayInteractor.worker = wordOfDayWorker
        wordOfDayInteractor.presenter = wordOfDayPresenter
        
        sut = wordOfDayInteractor
        worker = wordOfDayWorker
        presenter = wordOfDayPresenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchWordOfDaySuccess() {
        let request = WordOfDayModel.FetchWordOfDay.Request()
        worker.fetchSuccess = true
        sut.fetchWordOfDay(request: request)
        XCTAssertTrue(worker.isCalledFetchWordOfDay, "Not started worker.fetchWordOfDay(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
    }
    
    func testFetchWordOfDayFail() {
       let request = WordOfDayModel.FetchWordOfDay.Request()
        worker.fetchSuccess = false
        sut.fetchWordOfDay(request: request)
        XCTAssertTrue(worker.isCalledFetchWordOfDay, "Not started worker.fetchWordOfDay(:)")
        XCTAssertFalse(presenter.isCalledPrepareForPresent, "Started presenter.prepareForPresent(:) when shouldn't")
    }
}

