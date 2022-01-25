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
        self.color = subscription.color
    }
    
    var color: String? {
        didSet {
            guard oldValue != color else { return }
        }
    }
    
    var name: String? {
        didSet {
            if oldValue != name {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var price: Float? {
        didSet {
            if oldValue != price {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    var subscription: Subscription

    
    var date: Date? {
        didSet {
            if oldValue != date {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var reminderValue: Int? {
        didSet {
            if oldValue != reminderValue {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var recurrencyValue: Int? {
        didSet {
            if oldValue != recurrencyValue {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var recurrencyType: Calendar.Component = .year {
        didSet {
            if oldValue != recurrencyType {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var reminderType2: Calendar.Component = .year {
        didSet {
            if oldValue != reminderType2 {
                print("Can Save: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var reminderType: String? {
        didSet {
            
            }
    }
    
    private var isPaymentRecurrencyChanged: Bool {
        "\(recurrencyValue ?? 0) \(recurrencyType)" != subscription.paymentRecurrency
    }
    
    private var isReminderChanged: Bool {
        "\(reminderValue ?? 0) \(reminderType2)" != subscription.reminder
    }
    
    private var isDateChanged: Bool {
        date != subscription.commitment
    }
    
    private var isNameChanged: Bool {
        name != subscription.name
    }
    
    private var isColorChanged: Bool {
        color != subscription.color
    }
    
    private var isPriceChanged: Bool {
        price != subscription.price
    }
    
    var canSave: Bool {
        return isNameChanged || isPriceChanged || isDateChanged || isReminderChanged || isPaymentRecurrencyChanged || isColorChanged ///&& isDate ....
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
        subscription.name = name
        subscription.price = price ?? 0
        subscription.reminder = "\(reminderValue ?? 0) \(reminderType2)"
        subscription.commitment = date
        subscription.color = color
        subscription.paymentRecurrency = "\(recurrencyValue ?? 0) \(recurrencyType)"
        save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
