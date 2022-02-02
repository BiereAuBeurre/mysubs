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
    
    func testGoBack() throws {
        XCTAssertFalse(mockCoordinator.goBackIsCalled)
        viewModel.goBack()
        XCTAssertTrue(mockCoordinator.goBackIsCalled)
    }

    func testSavingSub() throws {
        XCTAssertFalse(mockStorageService.saveIsCalled)
        viewModel.date = Date().adding(.year, value: -100)
        viewModel.reminderValue = 1
        viewModel.recurrencyValue = 1
        viewModel.name = "coucou"
        viewModel.price = 20
        viewModel.reminderType = Calendar.Component.nanosecond
        viewModel.saveSub()
        XCTAssertTrue(mockStorageService.saveIsCalled)
    }
}
