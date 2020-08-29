//
//  ChooseLanguageSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 29.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp


final class ChooseLanguagePresentationLogicSpy: ChooseLanguagePresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    
    func prepareForPresent(response: ChooseLanguageModel.Language.Response) {
        isCalledPrepareForPresent = true
    }
}


final class ChooseLanguageSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: ChooseLanguageInteractor!
    private var presenter: ChooseLanguagePresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let chooseLanguageInteractor = ChooseLanguageInteractor()
        let chooseLanguagePresenter = ChooseLanguagePresentationLogicSpy()
        
        chooseLanguageInteractor.presenter = chooseLanguagePresenter
        
        sut = chooseLanguageInteractor
        presenter = chooseLanguagePresenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testChooseLanguage() {
        let request = ChooseLanguageModel.Language.Request()
        sut.loadLanguages(request: request)
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
    }
}
