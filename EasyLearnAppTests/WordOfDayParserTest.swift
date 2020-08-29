//
//  WordOfDayParserTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 29.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

class WordOfDayParserTest: XCTestCase {
    
    private var sut: WordOfDayParse!
    
    override func setUp() {
        sut = WordOfDayParser()
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParsing() {
        var result: WordOfDay?
        let expectation = self.expectation(description: "Parsing")
        sut.fetchWordOfDay { apiResponse, error in
            if let apiResponse = apiResponse {
                result = apiResponse
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result?.wordValue)
        XCTAssertNotNil(result?.dateValue)
        XCTAssertNotNil(result?.noteValue)
        XCTAssertTrue(result?.definitionValue.count ?? 0 > 0)
        XCTAssertTrue(result?.exampleValue.count ?? 0 > 0)
    }
}

