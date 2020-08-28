//
//  AddWordSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 28.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class AddWordWorkingLogicSpy: TranslationParse {
    
    private(set) var isCalledGetWordMeaning = false
    
    var haveTranslations = true
    var translations = ["translation1", "translation2"]
    
    func getWordMeaning(word: String, completion: @escaping ([String]?, String?) -> ()) {
        isCalledGetWordMeaning = true
        if haveTranslations {
            completion(translations, nil)
        } else {
            completion(nil, "error")
        }
    }
}

final class AddWordPresentationLogicSpy: PresentTranslations {

    private(set) var isCalledPresentTranslations = false
    
    func presentTranslations(response: AddWordModel.WordTranslations.Response) {
        isCalledPresentTranslations = true
    }
}


final class AddWordSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: AddWordInteractor!
    private var worker: AddWordWorkingLogicSpy!
    private var presenter: AddWordPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let addWordInteractor = AddWordInteractor()
        let addWordWorker = AddWordWorkingLogicSpy()
        let addWordPresenter = AddWordPresentationLogicSpy()
        
        addWordInteractor.worker = addWordWorker
        addWordInteractor.presenter = addWordPresenter
        
        sut = addWordInteractor
        worker = addWordWorker
        presenter = addWordPresenter
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchWordTranslationsSuccess() {
        let request = AddWordModel.WordTranslations.Request(word: "word")
        worker.haveTranslations = true
        sut.fetchWordTranslations(request: request)
        XCTAssertTrue(worker.isCalledGetWordMeaning, "Not started worker.getWordMeaning(:)")
        XCTAssertTrue(presenter.isCalledPresentTranslations, "Not started presenter.presentTranslations(:)")
    }
    
    func testFetchWordTranslationsFail() {
        let request = AddWordModel.WordTranslations.Request(word: "word")
        worker.haveTranslations = false
        sut.fetchWordTranslations(request: request)
        XCTAssertTrue(worker.isCalledGetWordMeaning, "Not started worker.getWordMeaning(:)")
        XCTAssertFalse(presenter.isCalledPresentTranslations, "Started presenter.presentTranslations(:) when shouldn't be called")
    }
}
