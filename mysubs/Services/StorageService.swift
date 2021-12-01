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
    
    func loadSubs() throws -> [SubInfo] {
        let fetchRequest: NSFetchRequest<SubscriptionEntity> = SubscriptionEntity.fetchRequest()
        let subscriptionEntities: [SubscriptionEntity]
        do { subscriptionEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        let subs = subscriptionEntities.map { (subscriptionEntity) -> SubInfo in
            return SubInfo(from: subscriptionEntity)
        }
        return subs
    }
    
    func saveSubs(_ subInfo: SubInfo) throws {
        let subscriptionEntity = SubscriptionEntity(context: viewContext)
        subscriptionEntity.category = subInfo.category
        subscriptionEntity.commitment = subInfo.commitment
        subscriptionEntity.extraInfo = subInfo.extraInfo
        subscriptionEntity.name = subInfo.name
        subscriptionEntity.paymentRecurrency = subInfo.paymentRecurrency
        subscriptionEntity.price = subInfo.price
        subscriptionEntity.reminder = subInfo.reminder
        subscriptionEntity.suggestedLogo = subInfo.suggestedLogo
//        print(subscriptionEntity.name)
    }
    
    func deleteSubs(_ subInfo: SubInfo) throws {
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
    }
    
}
