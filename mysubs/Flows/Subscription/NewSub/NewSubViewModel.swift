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

    init(coordinator: AppCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    var date: Date? {
        didSet {
            guard oldValue != date else { return }
        }
    }
    
    var reminderValue: Int? {
        didSet {
            
        }
    }
    
    var recurrencyValue: Int? {
        didSet {
            
        }
    }
    
    var recurrencyType: Calendar.Component = .year {
        didSet {
            
        }
    }
    
    var reminderType2: Calendar.Component = .year {
        didSet {
            
        }
    }
    
    var reminderType: String? {
        didSet {
            
            }
    }
    
    //MARK: -FIXME : fonctionne quand appelé dans le VC -> @objc func addButtonAction
    var price: Float? {
        didSet {
            guard oldValue != price else { return }
            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)

        }
    }
    //MARK: -FIXME
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)
        }
    }
    var canSaveSub: Bool {
        if name?.isEmpty == true /*|| price?.isZero == true */{
            viewDelegate?.showAlert("Champ manquant", "ajouter au moins un nom")
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
        newSub.name = name
        newSub.price = price ?? 0//Float(myprice ?? 0)
        var newDate = date
        newDate = newDate?.adding(reminderType2, value: -(reminderValue ?? 0))
        newDate = newDate?.adding(recurrencyType, value: recurrencyValue ?? 500)
        print("New date to get for notifications is : \(newDate ?? Date.now)")
        newSub.reminder = "\(reminderValue ?? 0) \(reminderType2)"
//        newSub.reminder = viewDelegate?.reminder.textField.text
        newSub.commitment = date /*viewDelegate?.commitmentDate.date*/
        newSub.paymentRecurrency = "Tous les \(recurrencyValue ?? 0) \(recurrencyType)"//viewDelegate?.recurrency.textField.text
        storageService.save()
        goBack()
    }
}
