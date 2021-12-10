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
    
    var subs: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(subs: subs)
        }
    }
    
    func showDetail() {
        coordinator.showNewSubScreenFor(category: "category")
    }
    
    func fetchSubs() {
        // appel reseau
        // response
        // subs appel reseau = subs
        subs = ["subs1", "subs2", "subs3"]
    }
    
}
