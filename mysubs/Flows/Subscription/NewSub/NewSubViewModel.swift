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
    var reminderType: Calendar.Component? //= .hour
    var price: Float?
    var color: String?
    var name: String?
    var subscriptions: [NSManagedObject] = []
    
    init(coordinator: AppCoordinatorProtocol, storageService: StorageServiceProtocol) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        //Minimum values to save a sub
        newSub.name = name
        newSub.price = price ?? 0
        
        newSub.icon = icon
        newSub.color = color
        let id = newSub.objectID.uriRepresentation().absoluteString

        //But if the date has value (mean notif has been switchOn) then both next values has to be saved, then generating a notif with it
        if date != nil {
            newSub.commitment = date
            if let reminderValue = reminderValue, let reminderType = reminderType, let recurrencyValue = recurrencyValue, let price = price, let date = date, let name = name {
                newSub.reminder = "\(reminderValue) \(reminderType.stringValue)"
                newSub.paymentRecurrency = "\(recurrencyValue) \(recurrencyType.stringValue)"
                self.notificationDate = date.adding(reminderType, value: -(reminderValue))
                self.notificationDate = self.notificationDate?.adding(recurrencyType, value: recurrencyValue)
                print("self.notification date in newsubVM is : \(self.notificationDate!)")
                notificationService.generateNotificationFor(name, reminderValue, price, self.notificationDate ?? Date.now, id: id, reminderType: reminderType)
            }
        }
        storageService.save()
        coordinator.goBack()
    }
    
}
