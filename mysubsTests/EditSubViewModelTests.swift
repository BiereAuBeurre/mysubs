//
//  EditSubViewModel.swift
//  mysubsTests
//
//  Created by Manon Russo on 01/02/2022.
//

import XCTest
@testable import mysubs

class EditSubViewModelTests: XCTestCase {
    let navigationController = UINavigationController()
    
    var viewModel: EditSubViewModel!
    var mockStorageService: MockStorageService!
    var mockCoordinator: MockCoordinator!
    var sub: Subscription!
    
    override func setUpWithError() throws {
        mockStorageService = MockStorageService()
        mockCoordinator = MockCoordinator()
        sub = Subscription(context: mockStorageService.viewContext)
        viewModel = EditSubViewModel(coordinator: mockCoordinator, storageService: mockStorageService, subscription: sub)
    }

    override func tearDownWithError() throws {
        mockStorageService = nil
        mockCoordinator = nil
        viewModel = nil
        
    }

    func testGoBack() throws {
        XCTAssertFalse(mockCoordinator.goBackIsCalled)
        viewModel?.goBack()
        XCTAssertTrue(mockCoordinator.goBackIsCalled)
    }
    
    func testSubscriptionSave() throws {
        XCTAssertFalse(mockStorageService.saveIsCalled)
        sub.name = "test"
        sub.price = 0
//        sub.icon = ""
        sub.color = ""
        viewModel.date = Date()
        viewModel.reminderValue = 8
        viewModel.recurrencyValue = 9
        viewModel.price = 9
        viewModel.reminderType = Calendar.Component.nanosecond
        viewModel.name = "test"
        sub.commitment = Date()
        viewModel.saveEditedSub()
        viewModel.save()
        XCTAssertTrue(mockStorageService.saveIsCalled)
        }

    func testDeleteSubscription() {
        XCTAssertFalse(mockStorageService.deleteIsCalled)
        viewModel.delete()
        XCTAssertTrue(mockStorageService.deleteIsCalled)
    }
}
