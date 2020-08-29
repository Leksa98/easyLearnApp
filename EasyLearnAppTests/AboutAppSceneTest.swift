//
//  AboutAppSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 29.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp


final class AboutAppPresentationLogicSpy: AboutAppPresentationLogic {
    
    private(set) var isCalledPrepareForPresent = false
    
    func prepareForPresent(response: AboutAppModel.AppDescription.Response) {
        isCalledPrepareForPresent = true
    }
}


final class AboutAppSceneTest: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut: AboutAppInteractor!
    private var presenter: AboutAppPresentationLogicSpy!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        
        let aboutAppInteractor = AboutAppInteractor()
        let aboutAppPresenter = AboutAppPresentationLogicSpy()
        
        aboutAppInteractor.presenter = aboutAppPresenter
        
        sut = aboutAppInteractor
        presenter = aboutAppPresenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Public Methods
    
    func testFetchAppDescription() {
        let request = AboutAppModel.AppDescription.Request()
        sut.fetchDescription(request: request)
        XCTAssertTrue(presenter.isCalledPrepareForPresent, "Not started presenter.prepareForPresent(:)")
    }
}
