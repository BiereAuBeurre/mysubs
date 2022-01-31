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
        self.recurrency = subscription.paymentRecurrency
        self.icon = subscription.icon
    }
    
    private var subscription: Subscription {
      didSet {
//          self.price = subscription.price
//          self.name = subscription.name
//          self.color = subscription.color
//          self.reminder = subscription.reminder
//          self.date = subscription.commitment
//          self.recurrency = subscription.paymentRecurrency
//          self.icon = subscription.icon
      }
  }
    
    var notificationDate: Date?

    var icon: Data? {
        didSet {
            guard oldValue != icon else { return }
            print("Can Save icon: \(canSave ? "YES" : "NO" )")

        }
    }
    
    var recurrency: String? {
        didSet {
            guard oldValue != recurrency else { return }
            print("Can Save recurrency: \(canSave ? "YES" : "NO" )")

        }
    }
    
    var reminder: String?
//    {
//        didSet {
//            guard oldValue != reminder else { return }
//            print("Can Save reminder: \(canSave ? "YES" : "NO" )")
//
//        }
//    }
    var color: String?
    {
        didSet {
            guard oldValue != color else { return }
            print("Can Save color: \(canSave ? "YES" : "NO" )")

        }
    }
    
    var name: String? {
//        subscription.name
        didSet {
            if oldValue != name {
                print("Can Save name: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var price: Float? {
        didSet {
            if oldValue != price {
                print("Can Save price: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var date: Date?
//    {
//        didSet {
//            if oldValue != date {
//                print("Can Save date: \(canSave ? "YES" : "NO" )")
//            }
//        }
//    }
    
    var reminderValue: Int? {
        didSet {
            if oldValue != reminderValue {
                print("Can Save reminder value : \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var recurrencyValue: Int? {
        didSet {
            if oldValue != recurrencyValue {
                print("Can Save recurrency value: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var recurrencyType: Calendar.Component = .year {
        didSet {
            if oldValue != recurrencyType {
                print("Can Save recurrency type : \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var reminderType: Calendar.Component = .year {
        didSet {
            if oldValue != reminderType {
                print("Can Save reminderType2: \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    private var isPaymentRecurrencyChanged: Bool {
        recurrency != subscription.paymentRecurrency
    }
    
    private var isIconChanged: Bool {
        icon != subscription.icon
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
    
    //FIXME: si appelés dans canSave fait buguer les autres?!
//    private var isReminderChanged: Bool {
//       reminder != subscription.reminder
//    }
//    private var isRecurrencyChanged: Bool {
//        "\(recurrencyValue ?? 0) \(recurrencyType)" != subscription.paymentRecurrency
//    }
    var canSave: Bool {
        return isNameChanged || isPriceChanged || isPaymentRecurrencyChanged || isColorChanged || isIconChanged //|| isDateChanged || isRecurrencyChanged || isReminderChanged  ///&& isDate ....
    }
    
    
    func delete() {
        do {
            try storageService.delete(subscription)
            //  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [subscription.id])
        }
        catch { print("can't delete sub because of error",error, "\n", error.localizedDescription) }
    }
    
    func save() {
        storageService.save()
    }
    
    func saveEditedSub() {
        if isNameChanged {
            print("new name is being saved")
            subscription.name = name
        }
        if isPriceChanged {
            print("new price is being saved")
        subscription.price = price ?? 0
        }
        
        if isDateChanged {
            subscription.commitment = date
            print("new date is bieng saved")
        }
        subscription.reminder = reminder
//        subscription.commitment = date
        subscription.icon = icon
        subscription.color = color
        subscription.paymentRecurrency = recurrency

        //If user doesn't edit date, means the todays value is the good one
        if date == nil {
        notificationDate = Date.now
        notificationDate = notificationDate?.adding(reminderType, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate?.adding(recurrencyType, value: recurrencyValue ?? 0) ?? Date.now
        } else {
            notificationDate = date
//            subscription.commitment = date

        }
//        if let dateToGet = notificationDate {
//        notificationService.generateNotificationFor(name ?? "unkown", reminderValue ?? 0, price ?? 0, dateToGet)
//        print("New date to get for notifications is : \(dateToGet)")
//        }
//        }
        save()
//        guard let dateToGet = notificationDate,
//              guard let name = name,
//              let reminderValue = reminderValue,
//              let price = price else { return }
        print("edited notificationDate is", notificationDate)
        notificationService.generateNotificationFor(name ?? "unknown name", reminderValue ?? 1, price ?? 1, notificationDate ?? Date.now)
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
