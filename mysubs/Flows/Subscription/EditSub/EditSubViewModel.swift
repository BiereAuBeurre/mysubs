//
//  EditSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 13/12/2021.
//

import Foundation

class EditSubViewModel: NSObject {
    weak var viewDelegate: EditSubController?
    private let coordinator: AppCoordinatorProtocol
    let storageService: StorageServiceProtocol
    var notificationService = NotificationService()

    init(coordinator: AppCoordinatorProtocol, storageService: StorageServiceProtocol, subscription: Subscription) {
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
    
    var recurrencyType: Calendar.Component = .hour {
        didSet {
            if oldValue != recurrencyType {
                print("Can Save recurrency type : \(canSave ? "YES" : "NO" )")
            }
        }
    }
    
    var reminderType: Calendar.Component = .hour {
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
            let id = subscription.objectID.uriRepresentation().absoluteString
            notificationService.cancelnotif(for: id)
        }
        catch { print("can't delete sub because of error",error, "\n", error.localizedDescription) }
    }
    
    func save() {
        storageService.save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
    
    func saveEditedSub() {
        //Minimum values to save a sub
        //if isNameChanged{} utile?
        subscription.name = name
        subscription.price = price ?? 0
        
        //Color & icon
        subscription.icon = icon
        subscription.color = color
        
        //But if the date has value changed (mean notif has been recalculated) then both next values has to be saved, then generating a notif with it
        let id = subscription.objectID.uriRepresentation().absoluteString
        if isDateChanged {
            if date == nil {
                notificationService.cancelnotif(for: id)
            } else {
                // si je change la date sans désactiver, je reset tout au niveau des notif dans date did change dans le VC
                subscription.commitment = date
                if let reminderValue = reminderValue, let recurrencyValue = recurrencyValue, let price = price, let date = date, let name = name {
                    subscription.reminder = "\(reminderValue) \(reminderType.stringValue)"
                    subscription.paymentRecurrency = "\(recurrencyValue) \(recurrencyType.stringValue)"
                    self.notificationDate = date.adding(reminderType, value: -(reminderValue))
                    self.notificationDate = self.notificationDate?.adding(recurrencyType, value: recurrencyValue)
                    print("self.notification date in newsubVM is : \(self.notificationDate!)")
                    notificationService.generateNotificationFor(name, reminderValue, price, self.notificationDate ?? Date.now, id: id)
                }
            }
        }
        storageService.save()
        goBack()
    }
}

        
        
//        if isNameChanged {
//            print("new name is being saved")
//            subscription.name = name
//        }
//        if let name2 = name {
//            subscription.name = name2
//        }
//        if isPriceChanged {
//            print("new price is being saved")
//        subscription.price = price ?? 0
//        }
//
//        if isDateChanged {
//            subscription.commitment = date
//            print("new date is bieng saved")
//        }
//        subscription.reminder = reminder
//        subscription.commitment = date
//        subscription.icon = icon
//        subscription.color = color
//        subscription.paymentRecurrency = recurrency
//        save()
//
//        print("edited notificationDate is", notificationDate)
//        notificationService.generateNotificationFor(name ?? "unknown name", reminderValue ?? 1, price ?? 1, notificationDate ?? Date.now)
//
    
