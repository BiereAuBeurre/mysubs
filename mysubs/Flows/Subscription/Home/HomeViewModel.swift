//
//  HomeViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData

class HomeViewModel: NSObject {
    weak var viewDelegate: HomeViewController?
    private let coordinator: AppCoordinator
    let storageService: StorageService
    init(coordinator: AppCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService =  storageService
    }
    
    var subscriptions: [Subscription] = [] {
        didSet {
            viewDelegate?.refreshWith(subscriptions: subscriptions)
        }
    }
    
    var categorys: [SubCategory] = [] {
        didSet {
//            categoryName
            viewDelegate?.refreshWith2(categorys: categorys)
        }
    }
    

    
    func fetchSubscription() {
        print("fetching sub from viewmodel's method")
        do {
            subscriptions = try storageService.viewContext.fetch(Subscription.fetchRequest())
        }
        catch {
            print (error)
        }
    }
    
    func fetchCategories() {
        do {
        categorys = try storageService.viewContext.fetch(SubCategory.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func addNewCategory(_ categoryToSave: String) {
        let newCategory = SubCategory(context: storageService.viewContext)
//        categoryName = categoryToSave
        newCategory.name = categoryToSave
        storageService.save()
    }
    
    
    func showNewSub() {
        coordinator.showNewSubScreenFor(category: "category")
    }
    
    func showDetail(sub: Subscription) {
        coordinator.showDetailSubScreen(sub: sub)
    }
    
//    func fetchSubs() {
        // appel reseau
        // response
        // subs appel reseau = subs
//        subscriptions = []
//    }
    
}
