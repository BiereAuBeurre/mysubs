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
//    func loadSubs() throws -> [Subscription] {
        /// CoreData request, return a subscriptionEntity object that is convert into SubInfo as soon as it's loaded.
//        let fetchRequest: NSFetchRequest<Subscription> = Subscription.fetchRequest()
//        let subscriptions: [Subscription]
//        do { subscriptions = try viewContext.fetch(fetchRequest) }
//            return subscriptions }
//        do { subscriptions = try viewContext.fetch(fetchRequest) }
//        catch { throw error }
//        let loadedsub = subscriptions.map {  (subscriptions) -> Subscription in
//            return Subscription(from: subscriptions)
//        }
        //enlever le do au dessus
//        let subs = subscriptions.map { (subscription) -> Subscription in
        
//    }
//    func loadsubs() {
//        do {
//            viewModel?.subscriptions = try viewContext.fetch(Subscription.fetchRequest())
//        } catch { error }
//    }
    
    func saveSubs(name: String, price: Float) throws {
        // on peut tout enlever (parametres aussi), juste garder has changed
        let entity = NSEntityDescription.entity(forEntityName: "Subscription", in: viewContext)!
        let subscription = NSManagedObject(entity: entity, insertInto: viewContext)
        subscription.setValue(name, forKey: "name")
        subscription.setValue(price, forKey: "price")
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { throw error }
        }
    }
    
    func deleteSubs(_ object: NSManagedObject) throws {
        //on lui passe un nsmanaged object au lieu du sub, faire juste viewcontext.delete
        do {
        viewContext.delete(object)
        try viewContext.save()
        } catch { throw error }
    }
}
