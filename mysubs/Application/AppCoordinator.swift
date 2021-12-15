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
//    let window: UIWindow
        //déclarer ts les service ici, coreDataService...

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
//    init(window: UIWindow) {
//        self.window = window
//        navigationController = UINavigationController()
//    }

    func start() {
        print("ok")
//        startHomeFlow()
        showSubScreen()
//        window.makeKeyAndVisible()
        // logique pour decider dans quel flow on commence, où notif envoi
    }
    
    func showSubScreen() {
        let homeVC = HomeViewController()
        let homeVCViewModel = HomeViewModel(coordinator: self)
        homeVCViewModel.viewDelegate = homeVC
        homeVC.viewModel = homeVCViewModel
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func showNewSubScreenFor(category: String)/*changer pour enum*/ {
        let newSubVC = NewSubController()
        let newSubVCViewModel = NewSubViewModel(coordinator: self, category: category)
    
        newSubVCViewModel.viewDelegate = newSubVC
        newSubVC.viewModel = newSubVCViewModel
//        newSubVCViewModel.category = category
        navigationController.pushViewController(newSubVC, animated: true)
    }
    
    func showDetailSubScreen(sub: String) {
        let editSubVC = EditSubController()
        let editSubViewModel = EditSubViewModel(coordinator: self)
        editSubViewModel.viewDelegate = editSubVC
        editSubVC.viewModel = editSubViewModel
        editSubViewModel.viewDelegate = editSubVC
//        editSubVC.coordinator = self
//        editSubVC.sub = sub
        navigationController.pushViewController(editSubVC, animated: true)
    }
    
    func goBack() {
        
//        let homeVC = HomeViewController()
//        let homeVCViewModel = HomeViewModel(coordinator: self)
//        homeVCViewModel.viewDelegate = homeVC
//        homeVC.viewModel = homeVCViewModel
//        homeVC.subscriptions = subscriptions
//        let homeVc = HomeViewController()
//        homeVc.coordinator = self

//        navigationController.viewControllers for each
        navigationController.popToRootViewController(animated: true)
        
//        navigationController.pushViewController(homeVC, animated: true)
    }
    
    ///toutes les methodes de navigation private, toujours appeler qch comme avec viewdidload() (dans start())
    
    private func startHomeFlow() {
//        let homeViewController = HomeViewController()
        //NewSubController()//aura propriété viewmodel
        //let homeViewModel = HomeViewModel() <- gere appel réseau, core data, on injecte service initialisé plus haut
       // homeViewController.viewModel = homeViewModel (aura un viewDelegate qui sera la viewcontroller)
        // (le viewmodel sera de type protocol : viewMOdel: HomeViewMOdelProtocol)
        // pour coordinator AppCoordinatorProtocol
        //dans le viewmodel, on aura coordinator en paramètre qui sera self, dans le home view model, HomeViewModel(coordinator: self, web service: service...)
    }
        /*func savePref()
         viewmodel.save()
         func save() {
         coordinator.goHome()*/
        
//        navigationController.setViewControllers([homeViewController], animated: false)
//        window.rootViewController = navigationController
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
//        navigationController.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.1313822269, blue: 0.2973747551, alpha: 1)
//
//        navigationController.navigationBar.standardAppearance = navBarAppearance
//        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
    
}
