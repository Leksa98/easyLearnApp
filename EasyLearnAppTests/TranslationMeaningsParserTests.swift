//
//  ParserTests.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 20.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

class TranslationMeaningsParserTests: XCTestCase {
    
    private var sut: TranslationMeaningsParser!
    
    override func setUp() {
        sut = TranslationMeaningsParser()
        super.setUp()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParsing() {
        let resultArray = ["компьютер", "вычислительная машина", "вычислитель", "счетчик", "компьютерный"]
        var testArray: [String] = []
        let expectation = self.expectation(description: "Parsing")
        sut.getWordMeaning(word: "computer") { translation, error in
            if let translation = translation {
                testArray = translation
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(resultArray, testArray)
    }
    
    func testEmptyRequest() {
        var testArray: [String] = []
        let expectation = self.expectation(description: "Parsing")
        sut.getWordMeaning(word: "") { translation, error in
            if let translation = translation {
                testArray = translation
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual([], testArray)
    }
    
    func testIncorrectInput() {
        var testArray: [String] = []
        let expectation = self.expectation(description: "Parsing")
        sut.getWordMeaning(word: "qqq") { translation, error in
            if let translation = translation {
                testArray = translation
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual([], testArray)
    }
}
