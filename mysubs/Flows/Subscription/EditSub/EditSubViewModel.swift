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
    init(coordinator: AppCoordinator, storageService: StorageService, subscription: Subscription) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.subscription = subscription
    }
    
    var subscription: Subscription //{
//        didSet {
//            viewDelegate?.refreshWith(subscription: viewDelegate?.sub)
//        }
//    }
    
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
        // Attributing value from the view delegate
        guard let name = viewDelegate?.name.textField.text,
              let price = Float(viewDelegate?.price.textField.text ?? "0"),
              let firstPaymentDate = viewDelegate?.commitmentDate.date,
              let recurrency = viewDelegate?.recurrency.textField.text,
              let reminder = viewDelegate?.reminder.textField.text else { return }
            
        //Checking if the value has change, if it does, its saved (for each values)
        if price != subscription.price {
            subscription.setValue(price, forKey: "price")
            print("price has been modified")
        }
        
        if firstPaymentDate != subscription.commitment {
            subscription.setValue(firstPaymentDate, forKey: "commitment")
        }
        
        changeIfEditedValueFor(name, subscription.name, "name")
        changeIfEditedValueFor(reminder, subscription.reminder, "reminder")
        changeIfEditedValueFor(recurrency, subscription.paymentRecurrency, "paymentRecurrency")
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
    }
}
