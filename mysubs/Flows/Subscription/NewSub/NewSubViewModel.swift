//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation

class NewSubViewModel: NSObject {
    weak var viewDelegate: HomeViewController?
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var subs: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(subs: subs)
        }
    }
    
    
    
    func showHomeVC() {
        coordinator.showHomeScreen()
    }
}
