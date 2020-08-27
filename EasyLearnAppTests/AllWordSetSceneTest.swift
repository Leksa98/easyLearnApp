//
//  AllWordSetSceneTest.swift
//  EasyLearnAppTests
//
//  Created by Alexandra Gertsenshtein on 27.08.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import XCTest
@testable import EasyLearnApp

final class AllWordSetPresentationLogicSpy: AllWordSetTablePresentationLogic {
    
    private(set) var isCalledPresentFetchedUsers = false
    var wordSets: [WordSetModel]?
    
    func presentSets(response: AllWordSetTableModel.FetchStudySets.Response) {
        isCalledPresentFetchedUsers = true
        wordSets = response.studySets
    }
}

final class AllWordSetWorkingLogicSpy: DataStorageAllWordSet {
    
    private(set) var isCalledFetchAllWordSet = false
    private(set) var isCalleddeleteWordSet = false
    
    let wordSets = [WordSetModel(name: "House", emoji: "🏠"),
                    WordSetModel(name: "Weather", emoji: "🌦")]
    
    func fetchAllWordSet() -> [WordSetModel]? {
        isCalledFetchAllWordSet = true
        return wordSets
    }
    
    func deleteWordSet(name: String) {
        isCalleddeleteWordSet = true
    }
}

final class AllWordSetSceneTest: XCTestCase {

  // MARK: - Private Properties

  private var sut: AllWordSetTableInteractor!
  private var worker: AllWordSetWorkingLogicSpy!
  private var presenter: AllWordSetPresentationLogicSpy!

  // MARK: - Lifecycle

  override func setUp() {
    super.setUp()

    let allWordSetInteractor = AllWordSetTableInteractor()
    let allWordSetWorker = AllWordSetWorkingLogicSpy()
    let allWordSetPresenter = AllWordSetPresentationLogicSpy()

    allWordSetInteractor.worker = allWordSetWorker
    allWordSetInteractor.presenter = allWordSetPresenter

    sut = allWordSetInteractor
    worker = allWordSetWorker
    presenter = allWordSetPresenter
  }

  override func tearDown() {
    sut = nil
    worker = nil
    presenter = nil

    super.tearDown()
  }

  // MARK: - Public Methods

  func testAllWordSet() {
    let request = AllWordSetTableModel.FetchStudySets.Request()
    sut.fetchStudySets(request: request)
    
    XCTAssertTrue(worker.isCalledFetchAllWordSet, "Not started worker.fetchAllWordSet(:)")
    XCTAssertTrue(presenter.isCalledPresentFetchedUsers, "Not started presenter.presentSets(:)")
    XCTAssertEqual(worker.wordSets.count, presenter.wordSets?.count)
  }

  func testDeleteWordSet() {
    let request = AllWordSetTableModel.DeleteSet.Request(setName: "House")
    sut.deletefromCoreData(request: request)
    
    XCTAssertTrue(worker.isCalleddeleteWordSet, "Not started worker.fetchAllWordSet(:)")
  }
}
