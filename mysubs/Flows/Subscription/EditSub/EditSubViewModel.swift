//
//  EditSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 13/12/2021.
//

import Foundation
import UserNotifications

class EditSubViewModel: NSObject {
    weak var viewDelegate: EditSubController?
    private let coordinator: AppCoordinator
    let storageService: StorageService
    init(coordinator: AppCoordinator, storageService: StorageService, subscription: Subscription) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.subscription = subscription
        self.price = subscription.price
        self.name = subscription.name
    }
    
    var name: String? {
        didSet {
            if oldValue != name {
                print("Can Save: \(canSave ? "YES" : "NO" )")
                // viewDelegate.canSaveStatusDidChange(canSave: canSave)..
            }
        }
    }
    
    var price: Float? {
        didSet {
            if oldValue != price {
                print("Can Save: \(canSave ? "YES" : "NO" )")
                // viewDelegate.canSaveStatusDidChange(canSave: canSave)..
            }
        }
    }
    var subscription: Subscription //{
//        didSet {
//            viewDelegate?.refreshWith(subscription: subscription)
//        }
//    }
    
    var date: Date? {
        didSet {
            guard oldValue != date else { return }
            subscription.setValue(subscription.commitment, forKey: "commitment")
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
    
    
    private var isNameChanged: Bool {
        name != subscription.name
    }
    
    private var isPriceChanged: Bool {
        price != subscription.price
    }
    
    var canSave: Bool {
        return isNameChanged || isPriceChanged///&& isDate ....
    }
    
    
    func delete() {
        do {
            try storageService.delete(subscription)
            //  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [subscription.id])
        }
        catch { print(error) }
    }
    
    func save() {
        storageService.save()
    }
    
    func saveEditedSub() {
        print("name saved \(name ?? "")")
        subscription.name = name
        print("price saved \(price ?? 0)")

        subscription.price = price ?? 0
        save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
