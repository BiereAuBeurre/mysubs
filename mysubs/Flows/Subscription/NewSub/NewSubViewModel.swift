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
    private let storageService: StorageService
//    private let category: String

    init(coordinator: AppCoordinator,/*, category: String, */storageService: StorageService) {
        self.coordinator = coordinator
//        self.category = category
        self.storageService = storageService
    }
    
    var name: String? {
        didSet {
            guard oldValue != name else { return }
//            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)
        }
    }
    
    var canSaveSub: Bool {
        if name?.isEmpty == true {
//        viewDelegate?.showAlert("Champ manquant", "ajouter au moins un nom")
        return false
        } else {
            return true
        }
        
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
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        newSub.name = viewDelegate?.nameField.text
        let myprice = Float(viewDelegate?.priceField.text ?? "0")
        newSub.price = Float(myprice ?? 0)
        storageService.save()
        goBack()
    }
}
