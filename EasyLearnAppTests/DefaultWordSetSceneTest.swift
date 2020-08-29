//
//  DefaultWordSetSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 29.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class DefaultWordSetWorkingLogicSpy: DefaultWordSetsNetworkRequest {
    
    private(set) var isCalledFetchDefaultWordSets = false
    var fetchSuccess = true
    
    func fetchDefaultWordSets(completion: @escaping (DefaultWordSet?, String?) -> ()) {
        isCalledFetchDefaultWordSets = true
        if fetchSuccess {
            completion(DefaultWordSet(defaultSet: [DefaultSet(name: "name", emoji: "emoji", words: [WordToLearn(wordToLearn: "word", translation: "translation")])]), nil)
        } else {
            completion(nil, "error")
        }
    }
}

final class DefaultWordSetPresentationLogicSpy: DefaultWordSetPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    
    func prepareForPresent(response: DefaultWordSetModel.FetchDefaultSets.Response) {
        isCalledPrepareForPresent = true
    }
}


final class DefaultWordSetSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: DefaultWordSetInteractor!
    private var worker: DefaultWordSetWorkingLogicSpy!
    private var presenter: DefaultWordSetPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let defaultWordSetInteractor = DefaultWordSetInteractor()
        let defaultWordSetWorker = DefaultWordSetWorkingLogicSpy()
        let defaultWordSetPresenter = DefaultWordSetPresentationLogicSpy()
        
        defaultWordSetInteractor.worker = defaultWordSetWorker
        defaultWordSetInteractor.presenter = defaultWordSetPresenter
        
        sut = defaultWordSetInteractor
        worker = defaultWordSetWorker
        presenter = defaultWordSetPresenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchDefaultSetsSuccess() {
        let request = DefaultWordSetModel.FetchDefaultSets.Request()
        worker.fetchSuccess = true
        sut.fetchDefaultSet(request: request)
        XCTAssertTrue(worker.isCalledFetchDefaultWordSets, "Not started worker.fetchDefaultWordSets(:)")
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
    }
    
    func testFetchDefaultSetsFail() {
        let request = DefaultWordSetModel.FetchDefaultSets.Request()
        worker.fetchSuccess = false
        sut.fetchDefaultSet(request: request)
        XCTAssertTrue(worker.isCalledFetchDefaultWordSets, "Not started worker.fetchDefaultWordSets(:)")
        XCTAssertFalse(presenter.isCalledPrepareForPresent, "Started presenter.prepareForPresent(:) when shouldn't")
    }
}
