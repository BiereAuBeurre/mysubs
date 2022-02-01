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
    private let coordinator: AppCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    var notificationService = NotificationService()
    var notificationDate: Date?
    var icon: Data?
    var date: Date?
    var reminderValue: Int?
    var recurrencyValue: Int?
    var recurrencyType: Calendar.Component = .hour
    var reminderType: Calendar.Component = .hour
    var price: Float?
    var color: String?
    var name: String?
    var subscriptions: [NSManagedObject] = []
    
    init(coordinator: AppCoordinatorProtocol, storageService: StorageServiceProtocol) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    func goBack() {
        coordinator.goBack()
    }
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        //Minimum values to save a sub
        newSub.name = name
        newSub.price = price ?? 0
        
        //But is the date has value (mean notif has been switch) then both next values has to be saved, then generating a notif with it
        if date != nil {
        newSub.commitment = date
            if let reminderValue = reminderValue, let recurrencyValue = recurrencyValue, let price = price, let notificationDate = date, let name = name {
                newSub.reminder = "\(reminderValue) \(reminderType)"
                newSub.paymentRecurrency = "Tous les \(recurrencyValue) \(recurrencyType)"
                self.notificationDate = notificationDate.adding(reminderType, value: -(reminderValue))
                self.notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue)
                print("notification date in newsubVM is :", notificationDate)
                notificationService.generateNotificationFor(name, reminderValue, price, notificationDate )
            }
    }
        storageService.save()
        goBack()
    }
}
