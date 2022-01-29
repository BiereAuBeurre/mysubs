//
//  MockCoordinator.swift
//  mysubsTests
//
//  Created by Manon Russo on 28/01/2022.
//

import Foundation
import UIKit
@testable import mysubs

class MockCoordinator: AppCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    var coordinatorStartCalled = false
    
    func start() {
        print(#function)
        print("new start is ok")
        coordinatorStartCalled = true
    }

    func showSubScreen() {
        print(#function)

    }

    func showNewSubScreenFor(category: String) {
        print(#function)
    }

    func showDetailSubScreen(sub: Subscription, categorys: [SubCategory]) {
        print(#function)
    }

    func goBack() {
        start()
        print(#function)
    }
    
}

