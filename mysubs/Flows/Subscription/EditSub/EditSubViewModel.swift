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
    var notificationService = NotificationService()

    init(coordinator: AppCoordinator, storageService: StorageService, subscription: Subscription) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.subscription = subscription
        self.price = subscription.price
        self.name = subscription.name
        self.color = subscription.color
        self.reminder = subscription.reminder
        self.date = subscription.commitment
        self.recurrency = subscription.paymentRecurrency// ?? "non renseigné"
        self.icon = subscription.icon
    }
    
    var subscription: Subscription {
      didSet {

      }
  }
    
    var notificationDate = Date()

    var icon: Data?
    
    var recurrency: String?
//    {
//        didSet {
//
//            guard oldValue != recurrency else { return }
//        }
//    }
    
    var reminder: String?
//    {
//        didSet {
//            guard oldValue != reminder else { return }
//        }
//    }
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
    
//    var reminderType: String? {
//        didSet {
//
//            }
//    }
    
    private var isPaymentRecurrencyChanged: Bool {
        recurrency != subscription.paymentRecurrency
    }
    
    private var isReminderChanged: Bool {
       reminder != subscription.reminder
    }
    
//    private var isRecurrencyChanged: Bool {
//        "\(recurrencyValue ?? 0) \(recurrencyType)" != subscription.paymentRecurrency
//    }
    
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
        return isNameChanged || isPriceChanged || isDateChanged || isReminderChanged || isPaymentRecurrencyChanged || isColorChanged// || isRecurrencyChanged ///&& isDate ....
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
    func generateNotifDate() -> Date {
        notificationDate = date ?? Date.now
        notificationDate = notificationDate.adding(reminderType2, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue ?? 0) ?? Date.now
        print("New date to get for notifications is : \(notificationDate)")
        return notificationDate
    }
    
    func saveEditedSub() {
        subscription.name = name
        subscription.price = price ?? 0
        subscription.reminder = reminder
        subscription.commitment = date
        subscription.icon = icon
        subscription.color = color
        subscription.paymentRecurrency = recurrency
//        generateNotifDate()
        notificationDate = date ?? Date.now
        notificationDate = notificationDate.adding(reminderType2, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue ?? 0) ?? Date.now
        print("New date to get for notifications is : \(notificationDate)")
        notificationService.generateNotificationFor(name ?? "unkown", reminderValue ?? 0, price ?? 0, notificationDate)

        save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
