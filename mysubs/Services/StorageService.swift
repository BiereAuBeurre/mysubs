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
    
    //MARK: Category Methods
    func loadCategory() throws -> [CategoryInfo] {
        /// CoreData request, return a subscriptionEntity object that is convert into SubInfo as soon as it's loaded.
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let categoryEntities: [CategoryEntity]
        do { categoryEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        let category = categoryEntities.map { (categoryEntity) -> CategoryInfo in
            return CategoryInfo(from: categoryEntity)
        }
        return category
    }
    
    func saveCategory(_ categoryInfo: CategoryInfo) throws {
        let categoryEntity = CategoryEntity(context: viewContext)
        categoryEntity.name = categoryInfo.name
        print(categoryEntity)
    }
    
    func deleteCategory(_ categoryInfo: CategoryInfo) throws {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", categoryInfo.name)
        fetchRequest.predicate = predicate
        let categoriesEntities: [ CategoryEntity]
        do { categoriesEntities = try viewContext.fetch(fetchRequest)
            categoriesEntities.forEach { (categoryEntity) in
                viewContext.delete(categoryEntity) }
            /// Save once recipe is deleted.
            try viewContext.save() }
        catch { throw error }
        print(categoriesEntities)
    }
    
    //MARK: Subscription methods
    func loadSubs() throws -> [Subscription] {
        /// CoreData request, return a subscriptionEntity object that is convert into SubInfo as soon as it's loaded.
        
        let fetchRequest: NSFetchRequest<SubscriptionEntity> = SubscriptionEntity.fetchRequest()
        let subscriptionEntities: [SubscriptionEntity]
        do { subscriptionEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        let subs = subscriptionEntities.map { (subscriptionEntity) -> Subscription in
            return Subscription(from: subscriptionEntity)
        }
        return subs
    }
    
    func saveSubs(_ subInfo: Subscription) throws {
        let subscriptionEntity = SubscriptionEntity(context: viewContext)
        subscriptionEntity.category = subInfo.category
        subscriptionEntity.commitment = subInfo.commitment
        subscriptionEntity.extraInfo = subInfo.extraInfo
        subscriptionEntity.name = subInfo.name
        subscriptionEntity.paymentRecurrency = subInfo.paymentRecurrency
        subscriptionEntity.price = subInfo.price
        subscriptionEntity.reminder = subInfo.reminder
        subscriptionEntity.suggestedLogo = subInfo.suggestedLogo
        print(subscriptionEntity)
    }
    
    func deleteSubs(_ subInfo: Subscription) throws {
        let fetchRequest: NSFetchRequest<SubscriptionEntity> = SubscriptionEntity.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", subInfo.name)
        fetchRequest.predicate = predicate
        let subscriptionEntities: [ SubscriptionEntity]
        do { subscriptionEntities = try viewContext.fetch(fetchRequest)
            subscriptionEntities.forEach { (subscriptionEntity) in
                viewContext.delete(subscriptionEntity) }
            /// Save once recipe is deleted.
            try viewContext.save() }
        catch { throw error }
        print(subscriptionEntities)
    }
}
