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
    
    var canSave: Bool {
        return isNameChanged //&& isDate ....
    }
    
    
    func delete() {
        do {
            try storageService.delete(subscription)
        }
        catch {
            print(error)
        }
    }
    
    func save() {
        storageService.save()
    }
    
    func saveEditedSub() {
        guard let name = name else {
            return
        }
        print("name saved \(name)")
        subscription.name = name

        // Attributing value from the view delegate
//        guard let name = subscription.name,//viewDelegate?.name.textField.text,
//              let price = Float?(subscription.price),//Float(viewDelegate?.price.textField.text ?? "0"),
//              let firstPaymentDate = subscription.commitment,//viewDelegate?.commitmentDate.date,
//              let recurrency = /*subscription.paymentRecurrency,*/viewDelegate?.recurrency.textField.text,
//              let reminder = subscription.reminder else { return }//viewDelegate?.reminder.textField.text

        //Checking if the value has change, if it does, its saved (for each values)
//        if price != subscription.price {
        //FIXME: ?? (1ère ligne rajoutée)
//        subscription.setValue(price, forKey: "price")
//        subscription.setValue(reminder, forKey: "reminder")
//        }
        
//        if firstPaymentDate != subscription.commitment {
//            subscription.setValue(firstPaymentDate, forKey: "commitment")
//        }
//        
//        changeIfEditedValueFor(name, subscription.name, "name")
//        changeIfEditedValueFor(reminder, subscription.reminder, "reminder")
//        changeIfEditedValueFor(recurrency, subscription.paymentRecurrency, "paymentRecurrency")
        save()
    }
    
    private func changeIfEditedValueFor(_ value1: String, _ value2: String?, _ value3: String) {
        if value1 != value2 ?? "" {
            subscription.setValue(value1, forKey: value3 )
            print("\(value3) field has been modified")
        }
    }
    
    func goBack() {
        coordinator.goBack()
        
      //  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [subscription.id])
    }
}
