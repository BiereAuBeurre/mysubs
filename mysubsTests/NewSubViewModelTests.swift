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
//    var coordinatorStartCalled = false
    let navigationController = UINavigationController(rootViewController: UIViewController())

    var viewModel: NewSubViewModel!
    var storageService: StorageService!
    var coordinator: CoordinatorMock!

    override func setUpWithError() throws {
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!

        // MARK: - persistentStoreDescription
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true

        // MARK: - persistentContainer
        let persistentContainer = NSPersistentContainer(name: "mysubs", managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        storageService = StorageService(persistentContainer: persistentContainer)
        coordinator = CoordinatorMock(navigationController: navigationController)
//        coordinator.configuration.protocolClasses = [CoordinatorMock.self]

        viewModel = NewSubViewModel(coordinator: coordinator, storageService: storageService)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storageService = nil
        coordinator = nil
    }

    func testExample() throws {
        XCTAssertFalse(coordinator.coordinatorStartCalled)
//        coordinator.start()
        viewModel.goBack()
        viewModel.saveSub()
        XCTAssertTrue(coordinator.coordinatorStartCalled)
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
