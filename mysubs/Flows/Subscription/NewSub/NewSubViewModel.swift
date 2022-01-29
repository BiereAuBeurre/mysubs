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
    var notificationDate = Date()
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
        newSub.price = price ?? 0
        notificationDate = date ?? Date.now
        notificationDate = notificationDate.adding(reminderType, value: -(reminderValue ?? 0)) ?? Date.now
        notificationDate = notificationDate.adding(recurrencyType, value: recurrencyValue ?? 500) ?? Date.now
        print("New date to get for notifications is : \(notificationDate)")
        newSub.reminder = "\(reminderValue ?? 0) \(reminderType)"
        newSub.commitment = date
        newSub.color = color
        newSub.icon = icon
        newSub.paymentRecurrency = "Tous les \(recurrencyValue ?? 0) \(recurrencyType)"
        storageService.save()
//        notificationService.requestNotificationAuthorization()
        notificationService.generateNotificationFor(name ?? "unkown", reminderValue ?? 0, price ?? 0, notificationDate)
        goBack()
    }
}
