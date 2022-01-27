//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData
import UIKit

class NewSubViewModel: NSObject {
    weak var viewDelegate: NewSubController?
    private let coordinator: AppCoordinator
    private let storageService: StorageService
    var notificationService = NotificationService()
    var notificationDate = Date()
    var icon: Data?
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
    
    var recurrencyType: Calendar.Component = .hour {
        didSet {
            
        }
    }
    
    var reminderType: Calendar.Component = .hour {
        didSet {
            
        }
    }
    
    var price: Float? {
        didSet {
            guard oldValue != price else { return }
            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)

        }
    }
    
    var color: String? {
        didSet {
            guard oldValue != color else { return }
        }
    }
    //MARK: -FIXME
    var name: String? {
        didSet {
            guard oldValue != name else { return }
//            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)
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
    }
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        newSub.name = name
        newSub.price = price ?? 0
        notificationDate = date ?? Date.now
        notificationDate = notificationDate.adding(reminderType, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue ?? 500) ?? Date.now
        print("New date to get for notifications is : \(notificationDate)")
        newSub.reminder = "\(reminderValue ?? 0) \(reminderType)"
        newSub.commitment = date
        newSub.color = color
        newSub.icon = icon
        newSub.paymentRecurrency = "Tous les \(recurrencyValue ?? 0) \(recurrencyType)"
        storageService.save()
        notificationService.generateNotificationFor(name ?? "unkown", reminderValue ?? 0, price ?? 0, notificationDate)
        goBack()
    }
}
