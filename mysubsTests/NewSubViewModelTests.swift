//
//  NewSubViewModelTests.swift
//  mysubsTests
//
//  Created by Manon Russo on 28/01/2022.
//

import XCTest
import CoreData
@testable import mysubs

class NewSubViewModelTests: XCTestCase {
    
    let navigationController = UINavigationController()
    
    var viewModel: NewSubViewModel!
    var storageService: MockStorageService!
    var coordinator: MockCoordinator!
    
    override func setUpWithError() throws {
        
        storageService = MockStorageService()
        coordinator = MockCoordinator()
        viewModel = NewSubViewModel(coordinator: coordinator, storageService: storageService)
    }
    
    override func tearDownWithError() throws {
        storageService = nil
        coordinator = nil
        viewModel = nil
    }

    func testGoBack() throws {
        XCTAssertFalse(coordinator.goBackIsCalled)
        XCTAssertFalse(storageService.saveIsCalled)
        viewModel.saveSub()

        viewModel.goBack()
        XCTAssertTrue(coordinator.goBackIsCalled)
        XCTAssertTrue(storageService.saveIsCalled)

    }
    
    func testSavingSub() throws {
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
