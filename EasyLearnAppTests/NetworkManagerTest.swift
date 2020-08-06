//
//  NetworkManagerTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 20.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

class NetworkManagerTest: XCTestCase {
    
    private var sut: NetworkManager!
    
    override func setUp() {
        sut = NetworkManager()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testEmptyInput() {
        var result = ""
        let expectation = self.expectation(description: "Request")
        sut.translateWord(word: "") { apiResponse, error in
            if let error = error {
                result = error
            }
            if apiResponse != nil {
                result = "No error"
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("Request failed", result)
    }
    
    func testUnableDecodeInput() {
        var result = ""
        let expectation = self.expectation(description: "Request")
        let userDefaults = UserDefaults.standard
        let prevLang = (userDefaults.object(forKey: "lang") as? String) ?? "en"
        userDefaults.set("en", forKey: "lang")
        sut.translateWord(word: "wr") { apiResponse, error in
            if let error = error {
                result = error
            }
            if apiResponse != nil {
                result = "No error"
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("Unable to decode data.", result)
        userDefaults.set(prevLang, forKey: "lang")
    }
    
    func testInput() {
        var result: TranslationModel?
        let expectation = self.expectation(description: "Request")
        let userDefaults = UserDefaults.standard
        let prevLang = (userDefaults.object(forKey: "lang") as? String) ?? "en"
        userDefaults.set("en", forKey: "lang")
        sut.translateWord(word: "computer") { apiResponse, error in
            if error != nil {
                result = nil
            }
            if let apiResponse = apiResponse {
                result = apiResponse
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(result)
        userDefaults.set(prevLang, forKey: "lang")
    }

}
