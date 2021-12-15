//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation

class NewSubViewModel: NSObject {
    weak var viewDelegate: NewSubController?
    private let coordinator: AppCoordinator
    private let category: String
    var newSubVC = NewSubController()
    var homeVC = HomeViewController()

    init(coordinator: AppCoordinator, category: String) {
        self.coordinator = coordinator
        self.category = category
    }
    
    var subscriptions: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(subscriptions: newSubVC.subscriptions)
        }
    }

    
    func goBack() {
        coordinator.goBack()
//        homeVC.subscriptions  = viewDelegate?.subscriptions ?? nil
    }
}
