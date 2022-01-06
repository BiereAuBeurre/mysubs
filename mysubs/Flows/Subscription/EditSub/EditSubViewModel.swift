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
    init(coordinator: AppCoordinator, storageService: StorageService) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    var subscription: Subscription? {
        didSet {
//            viewDelegate?.refreshWith(subscription: viewDelegate?.sub)
        }
    }
    
//    var categorys: [SubCategory] = [] {
//        didSet {}
//    }
    
    func delete() {
        do {
            try storageService.delete(subscription!)
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
              let paymentRecurrency = viewDelegate?.formatteDate(),
              let reminder = viewDelegate?.reminder.textField.text else { return }
        
        //Checking if the value has change, if it does, its saved (for each values)
        if price != subscription?.price {
            subscription?.setValue(price, forKey: "price")
            print("price has been modified")
        }
        saveIfEdited(name, subscription?.name, "name")
        saveIfEdited(paymentRecurrency, subscription?.commitment, "commitment")
        saveIfEdited(reminder, subscription?.reminder, "reminder")
        save()
    }
    
    func saveIfEdited(_ value1: String, _ value2: String?, _ value3: String) {
        if value1 != value2 ?? "" {
            subscription?.setValue(value1, forKey: value3 )
            print("\(value1) field has been modified")
        }
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
