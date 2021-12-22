//
//  HomeViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation

class HomeViewModel: NSObject {
    weak var viewDelegate: HomeViewController?
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var subscriptions: [Subscription] = [] {
        didSet {
            viewDelegate?.refreshWith(subscriptions: subscriptions)
        }
    }
    
    var categorys: [Category] = []
    
    func showNewSub() {
        coordinator.showNewSubScreenFor(category: "category")
    }
    
    func showDetail(sub: Subscription) {
        coordinator.showDetailSubScreen(sub: sub)
    }
    
    func fetchSubs() {
        
        // appel reseau
        // response
        // subs appel reseau = subs
        subscriptions = []
    }
    
}
