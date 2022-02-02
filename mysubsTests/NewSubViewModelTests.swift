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
    var mockStorageService: MockStorageService!
    var mockCoordinator: MockCoordinator!
    
    override func setUpWithError() throws {
        
        mockStorageService = MockStorageService()
        mockCoordinator = MockCoordinator()
        viewModel = NewSubViewModel(coordinator: mockCoordinator, storageService: mockStorageService)
    }
    
    override func tearDownWithError() throws {
        mockStorageService = nil
        mockCoordinator = nil
        viewModel = nil
    }

    func testSavingSub() throws {
        viewModel.date = Date().adding(.year, value: -100)
        viewModel.reminderValue = 1
        viewModel.recurrencyValue = 1
        viewModel.name = "couocu"
        viewModel.price = 20
        viewModel.reminderType = Calendar.Component.nanosecond
        XCTAssertFalse(mockCoordinator.goBackIsCalled)
        viewModel.saveSub()
        //storageserviceSaveisCalle
        XCTAssertTrue(mockCoordinator.goBackIsCalled)
        XCTAssertTrue(mockStorageService.saveIsCalled)

    }
    



    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
