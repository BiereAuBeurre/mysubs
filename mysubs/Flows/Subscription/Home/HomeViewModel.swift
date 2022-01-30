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
    private let coordinator: AppCoordinatorProtocol
    let storageService: StorageService
    
    init(coordinator: AppCoordinatorProtocol, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService =  storageService
    }
    
    var subscriptions: [Subscription] = [] {
        didSet {
            viewDelegate?.refreshWith(subscriptions: subscriptions)
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
    
    func showNewSub() {
        coordinator.showNewSubScreenFor()
    }
    
    func showDetail(sub: Subscription) {
        coordinator.showDetailSubScreen(sub: sub)
    }

}

//    var categorys: [SubCategory] = [] {
//        didSet {
//            viewDelegate?.refreshWith2(categorys: categorys)
//        }
//    }

//    func fetchCategories() {
//        do {
//        categorys = try storageService.loadCategory()
//        } catch {
//            print(error)
//        }
//    }

//func addNewCategory(_ categoryToSave: String) {
//    let newCategory = SubCategory(context: storageService.viewContext)
//    newCategory.name = categoryToSave
//    storageService.save()
//}
