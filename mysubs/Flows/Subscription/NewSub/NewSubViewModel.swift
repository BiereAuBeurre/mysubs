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

    init(coordinator: AppCoordinator, category: String) {
        self.coordinator = coordinator
        self.category = category
    }
    
    var subs: [String] = [] {
        didSet {
            viewDelegate?.refreshWith(subs: subs)
        }
    }

    
    
    func goBack() {
        coordinator.goBack()

    }
}
