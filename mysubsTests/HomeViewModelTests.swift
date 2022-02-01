//
//  HomeViewModelTests.swift
//  mysubsTests
//
//  Created by Manon Russo on 01/02/2022.
//

import XCTest
@testable import mysubs

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockStorageService: MockStorageService!
    var mockCoordinator: MockCoordinator!
    
    var loadedSubscriptions: [Subscription] = []
    
    private let sub1 = Subscription()
    
    override func setUpWithError() throws {
        mockStorageService = MockStorageService()
        mockCoordinator = MockCoordinator()
        viewModel = HomeViewModel(coordinator: mockCoordinator, storageService: mockStorageService)
    }

    override func tearDownWithError() throws {
        mockStorageService = nil
        mockCoordinator = nil
//        viewModel = nil
    }

    func testShowNewSub() throws {
        XCTAssertFalse(mockCoordinator.showNewSubScreenForIsCalled)
        viewModel.showNewSub()
        XCTAssertTrue(mockCoordinator.showNewSubScreenForIsCalled)
    }

    func testShowDetailSub() throws {
        XCTAssertFalse(mockCoordinator.showDetailSubScreenIsCalled)
        viewModel.showDetail(sub: sub1)
        XCTAssertTrue(mockCoordinator.showDetailSubScreenIsCalled)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
