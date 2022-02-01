//
//  EditSubViewModel.swift
//  mysubsTests
//
//  Created by Manon Russo on 01/02/2022.
//

import XCTest

class EditSubViewModel: XCTestCase {
    let navigationController = UINavigationController()
    
    var viewModel: NewSubViewModel!
    var mockStorageService: MockStorageService!
    var mockCoordinator: MockCoordinator!
    
    override func setUpWithError() throws {
        mockStorageService = MockStorageService()
        mockCoordinator = MockCoordinator()
        viewModel = NewSubViewModel(coordinator: mockCoordinator, storageService: mockStorageService)    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
