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
              let paymentRecurrency = viewDelegate?.formatteDate(),//viewDelegate?.recurrency.textField.text,
              let reminder = viewDelegate?.reminder.textField.text else { return }
        
        //Checking if the value has change, if it does, its saved (for each values)
        if name != subscription?.name {
            subscription?.setValue(name, forKey: "name")
            print("name has been modified")
        }
        
        if price != subscription?.price {
            subscription?.setValue(price, forKey: "price")
            print("price has been modified")
        }
        
        if paymentRecurrency != subscription?.commitment {
            subscription?.setValue(viewDelegate?.formatteDate(), forKey: "commitment")
            print("payment recurrency has been modified")
        } else { print("no changes for the price") }
        
        if reminder != subscription?.reminder {
            subscription?.setValue(reminder, forKey: "reminder")
        }
        
        if reminder != subscription?.reminder {
            subscription?.setValue(reminder, forKey: "reminder")
            print("reminder has been modified")
        }
        save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
