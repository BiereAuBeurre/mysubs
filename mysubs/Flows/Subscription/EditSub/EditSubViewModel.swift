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
    let storageService: StorageService
    init(coordinator: AppCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    var subscription: Subscription? {
        didSet {
//            viewDelegate?.refreshWith(subscription: viewDelegate?.sub)
        }
    }
    
    var categorys: [SubCategory] = [] {
        didSet {}
    }
    
    func delete() {
        do {
            try storageService.delete(subscription!)
        }
        catch {
            print(error)
        }
    }

    func save() {
        storageService.save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
    //    func openReminderModal(categorys: [SubCategory]) {
    //        coordinator.openReminderModal(categorys: categorys)
    //    }
}
