//
//  EditSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 13/12/2021.
//

import Foundation

class EditSubViewModel: NSObject {
    weak var viewDelegate: EditSubController?
    private let coordinator: AppCoordinator
    let editSubVC = EditSubController()
    
    init(coordinator: AppCoordinator/*, subscription: Subscription*/) {
        self.coordinator = coordinator
//        self.subscription = subscription
    }
    
    var subscription: Subscription? {
        didSet {
            viewDelegate?.refreshWith(subscription: editSubVC.sub)
        }
    }
    
    func showDetailedSub(sub: Subscription) {
        coordinator.showDetailSubScreen(sub: sub)
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
}
