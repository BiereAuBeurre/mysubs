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
            viewDelegate?.refreshWith2(categorys: categorys)
        }
    }
    
    var totalAmount: String = "" {
        didSet {
            viewDelegate?.didComputetotalAmount()
        }
    }
    
    func fetchSubscription() {
        do {
            subscriptions = try storageService.loadsubs()
        }
        catch {
            print(error)
        }
    }
    
    func fetchCategories() {
        do {
        categorys = try storageService.loadCategory()
        } catch {
            print(error)
        }
    }
    
    func computeTotal() {
        if subscriptions.isEmpty == true {
            viewDelegate?.amountLabel.text = "- €"
        } else {
            var totalPrice: Float = 0
            for sub in subscriptions {
                totalPrice += sub.price
                totalAmount = viewDelegate?.amountLabel.text ?? "- €"
                totalAmount = "\(totalPrice) €"
            }
        }
    }
    
    func addNewCategory(_ categoryToSave: String) {
        let newCategory = SubCategory(context: storageService.viewContext)
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
