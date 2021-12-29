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
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var subscription: Subscription? {
        didSet {
//            viewDelegate?.refreshWith(subscription: viewDelegate?.sub)
        }
    }
    
    var categorys: [SubCategory] = [] {
        didSet {}
    }
    
    func openReminderModal(categorys: [SubCategory]) {
        coordinator.openReminderModal(categorys: categorys)
    }
    func goBack() {
        coordinator.goBack()
    }
    
}
