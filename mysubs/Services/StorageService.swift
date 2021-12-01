//
//  StorageService.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import CoreData

class StorageService {
    
    let viewContext: NSManagedObjectContext
    init(persistentContainer: NSPersistentCloudKitContainer = AppDelegate.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadSubs() {}
    func saveSubs() {}
    func deleteSubs() {}
    
}
