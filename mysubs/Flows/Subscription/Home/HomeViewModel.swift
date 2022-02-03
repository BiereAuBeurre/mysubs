//
//  HomeViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData

final class HomeViewModel: NSObject {
    
    // Properties
    weak var viewDelegate: HomeViewController?
    let storageService: StorageServiceProtocol
    private let coordinator: AppCoordinatorProtocol

    init(coordinator: AppCoordinatorProtocol, storageService: StorageServiceProtocol) {
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
    
    func showNewSub() {
        coordinator.showNewSubScreenFor()
    }
    
    func showDetail(sub: Subscription) {
        coordinator.showDetailSubScreen(sub: sub)
    }

}
