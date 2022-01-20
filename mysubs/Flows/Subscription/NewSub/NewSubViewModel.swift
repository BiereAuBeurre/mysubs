//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData
import UserNotifications

class NewSubViewModel: NSObject {
    weak var viewDelegate: NewSubController?
    private let coordinator: AppCoordinator
    private let storageService: StorageService
    
    var notificationDate = Date()
    
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
        // homeVC.subscriptions  = viewDelegate!.subscriptions
    }
    
    private func generateNotification() {//for subscription
        #if DEBUG
        
        let notificationInterval: Double = 5
        #else
        
        let notificationInterval: Double = 5
        #endif
       // let notificationInterval: Double = 5
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationInterval, repeats: false)
        //UNUserNotificationCenter.current().
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = name ?? "inknown"
        notificationContent.body = "The subscvription will renewm in 1 day"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.userInfo = ["id": "25"]
        notificationContent.categoryIdentifier = "identifier"
        let request = UNNotificationRequest(identifier: "42", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("error adding notification \(error)")
            } else {
                print("notification added suvvces")
            }
        }
        
        
    }
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        newSub.name = name
        newSub.price = price ?? 0//Float(myprice ?? 0)
        notificationDate = date ?? Date.now
        notificationDate = notificationDate.adding(reminderType2, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue ?? 500) ?? Date.now
        print("New date to get for notifications is : \(notificationDate)")
        newSub.reminder = "\(reminderValue ?? 0) \(reminderType2)"
//        newSub.reminder = viewDelegate?.reminder.textField.text
        newSub.commitment = date
        newSub.color = color/*viewDelegate?.commitmentDate.date*/
        print("save color is:\n newsub.color : \(newSub.color)\n color: \(color)")
        newSub.paymentRecurrency = "Tous les \(recurrencyValue ?? 0) \(recurrencyType)"//viewDelegate?.recurrency.textField.text
        storageService.save()
//        generateNotification()
        goBack()
    }
}
