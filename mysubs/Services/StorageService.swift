//
//  StorageService.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.

import CoreData

class StorageService {
    let viewContext: NSManagedObjectContext
    init(persistentContainer: NSPersistentCloudKitContainer = AppDelegate.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    //MARK: Category Methods
    
    func loadCategory() throws -> [SubCategory] {
        var categories = [SubCategory]()
        do {
            categories = try viewContext.fetch(SubCategory.fetchRequest())
        } catch {
            print(error)
        }
        return categories
    }
    
    func loadsubs() throws -> [Subscription] {
        var subscriptions = [Subscription]()
        do {
            subscriptions = try viewContext.fetch(Subscription.fetchRequest())
        } catch {
            print(error)
        }
        return subscriptions
    }
    
    func save()  {
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { print(error) }
        }
    }
    
    func delete(_ object: NSManagedObject) throws {
        //on lui passe un nsmanaged object au lieu du sub, faire juste viewcontext.delete
        do {
            viewContext.delete(object)
            try viewContext.save()
        } catch { throw error }
    }
}
