//
//  MockStorageService.swift
//  mysubsTests
//
//  Created by Manon Russo on 01/02/2022.
//

import CoreData
@testable import mysubs

class MockStorageService: StorageServiceProtocol {
    var viewContext: NSManagedObjectContext
    
    init() {
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
        self.viewContext = persistentContainer.viewContext
    }
    
    var loadsubsIsCalled = false
    func loadsubs() throws -> [Subscription] {
        loadsubsIsCalled = true
        return [FakeData.subscription1, FakeData.subscription2]
    }
    
    var saveIsCalled = false
    func save() {
        saveIsCalled = true
    }
    
    var deleteIsCalled = false
    func delete(_ object: NSManagedObject) throws {
        deleteIsCalled = true
    }
    
}
