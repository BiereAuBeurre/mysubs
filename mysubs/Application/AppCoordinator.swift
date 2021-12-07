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
    let window: UIWindow
        //déclarer ts les service ici, coreDataService...

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        print("ok")
        startHomeFlow()
        window.makeKeyAndVisible()
        // logique pour decider dans quel flow on commence, où notif envoi
    }
    
    private func startHomeFlow() {
        let homeViewController = HomeViewController() //aura propriété viewmodel
        //let homeViewModel = HomeViewModel() <- gere appel réseau, core data, on injecte service initialisé plus haut
       // homeViewController.viewModel = homeViewModel (aura un viewDelegate qui sera la viewcontroller)
        // (le viewmodel sera de type protocol : viewMOdel: HomeViewMOdelProtocol)
        // pour coordinator AppCoordinatorProtocol
        //dans le viewmodel, on aura coordinator en paramètre qui sera self, dans le home view model, HomeViewModel(coordinator: self, web service: service...)
        
        /*func savePref()
         viewmodel.save()
         func save() {
         coordinator.goHome()*/
        
        navigationController.setViewControllers([homeViewController], animated: false)
        window.rootViewController = navigationController
        let navBarAppearance = UINavigationBarAppearance()
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)

//        navigationController.navigationBar.backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
//        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
//        let imageTitleBar = UIImage(named: "subs_dark")
//        self.navigationController.navigationItem.titleView = UIImageView(image: imageTitleBar)
        
        }
    
}
