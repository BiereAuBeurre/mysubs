//
//  NewSubViewModel.swift
//  mysubs
//
//  Created by Manon Russo on 10/12/2021.
//

import Foundation
import CoreData

class NewSubViewModel: NSObject {
    weak var viewDelegate: NewSubController?
    private let coordinator: AppCoordinator
    private let storageService: StorageService

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
    //MARK: -FIXME
    var name: String? {
        didSet {
            guard oldValue != name else { return }
            viewDelegate?.canSaveStatusDidChange(canSave: canSaveSub)
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
    
    func saveSub() {
        let newSub = Subscription(context: storageService.viewContext)
        newSub.name = name
        newSub.price = price ?? 0//Float(myprice ?? 0)
        //FIXME: Convertir ici en date  du coup ? en se basant sur la commitmentDate, ça serait par ex
        //3 valeurs à stocker pour le rappel? 1 string pour l'affichage et valueType+valueNumber pour calcul notif en arrière
        //Essayer de recupérer une date pour setupé les notifs, marche là mais voir pour remplacer le .day par valueType (qui doit être de type Calendar.Component, pour le moment est un string)
        var newDate = date
        newDate = newDate?.adding(reminderType2, value: -(reminderValue ?? 0))
        print("new date is : \(String(describing: newDate))")
//        newDate.localized.unitTitle(reminderType2)
        //prendre date du date picker
        
        // li faire by adding date de prochaine facturation (cycle)
        // lui faire inverse de adding avec date de rappel calculée
        
        
        newSub.reminder = "\(reminderValue ?? 0) \(reminderType ?? "")"
        newSub.reminder = viewDelegate?.reminder.textField.text
        newSub.commitment = date /*viewDelegate?.commitmentDate.date*/
        newSub.paymentRecurrency = viewDelegate?.recurrency.textField.text
        storageService.save()
        goBack()
    }
}
