//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData

class NewSubViewModel: NSObject {
    weak var viewDelegate: NewSubController?
    private let coordinator: AppCoordinator
    private let category: String

    init(coordinator: AppCoordinator, category: String) {
        self.coordinator = coordinator
        self.category = category
    }
    
    var subscriptions: [NSManagedObject] = [] {
        didSet {
            // viewDelegate?.refreshWith(subscriptions: viewDelegate!.subscriptions)

        }
    }

    
    func goBack() {
        coordinator.goBack()
        // homeVC.subscriptions  = viewDelegate!.subscriptions
    }
}
