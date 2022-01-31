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
    private let storageService: StorageService
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
    
    init(coordinator: AppCoordinatorProtocol, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    func goBack() {
        coordinator.goBack()
    }
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        
        newSub.name = name
        if let price = price {
        newSub.price = price
        }
        notificationDate = date
        if let date = date {
            newSub.commitment = date
        }
        if let reminder = reminderValue {
            notificationDate = notificationDate?.adding(reminderType, value: -(reminder))
        newSub.reminder = "\(reminder) \(reminderType)"

        }
        if let recurrency = recurrencyValue {
            notificationDate = notificationDate?.adding(recurrencyType, value: recurrency)
        newSub.paymentRecurrency = "Tous les \(recurrency) \(recurrencyType)"

        }
        print("New date to get for notifications is : \(notificationDate)")
//        newSub.commitment = date
        newSub.color = color
        newSub.icon = icon
        storageService.save()
        goBack()

            guard let dateToGet = notificationDate,
                  let name = name,
                  let reminderValue = reminderValue,
                  let price = price else { return }
        notificationService.generateNotificationFor(name, reminderValue, price, dateToGet)
    }
}
