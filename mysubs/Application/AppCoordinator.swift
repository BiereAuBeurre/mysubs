//
//  AppCoordinator.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
     
    //déclarer ts les service ici, coreDataService..
    private let storageService: StorageService

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.storageService = StorageService()
    }

    func start() {
        print("ok")
        showSubScreen()
        // logique pour decider dans quel flow on commence, où notif envoi
    }
    
    func showSubScreen() {
        let homeVC = HomeViewController()
        let homeVCViewModel = HomeViewModel(coordinator: self, storageService: storageService)
        homeVCViewModel.viewDelegate = homeVC
        homeVC.viewModel = homeVCViewModel
//        homeVC.category = category
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func showNewSubScreenFor(category: String)/*changer pour enum*/ {
        let newSubVC = NewSubController()
        let newSubVCViewModel = NewSubViewModel(coordinator: self, category: category, storageService: storageService)
        newSubVCViewModel.viewDelegate = newSubVC
        newSubVC.viewModel = newSubVCViewModel
//        newSubVCViewModel.category = category
        navigationController.pushViewController(newSubVC, animated: true)
    }
    
    func showDetailSubScreen(sub: Subscription) {
        let editSubVC = EditSubController()
        let editSubViewModel = EditSubViewModel(coordinator: self)
        editSubViewModel.viewDelegate = editSubVC
        editSubVC.viewModel = editSubViewModel
        editSubVC.sub = sub
        navigationController.pushViewController(editSubVC, animated: true)
    }
    
    func openReminderModal() {
        let reminderModalVC = ReminderModalController()
        // Modal displaying settings
        reminderModalVC.modalPresentationStyle = .popover
        reminderModalVC.modalTransitionStyle = .coverVertical
        // To display as modal
        navigationController.present(reminderModalVC, animated: true, completion: nil)
    }
    func goBack() {
        navigationController.popToRootViewController(animated: true)
    }
}

///toutes les methodes de navigation private, toujours appeler qch comme avec viewdidload() (dans start())
    /*func savePref()
     viewmodel.save()
     func save() {
     coordinator.goHome()*/
