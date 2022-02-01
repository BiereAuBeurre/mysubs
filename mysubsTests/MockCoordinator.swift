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

    
    var navigationController = UINavigationController()
    var subscription: Subscription?

    var coordinatorStartCalled = false
    func start() {
        print(#function)
        print("new start is ok")
        coordinatorStartCalled = true
    }

    var showSubScreenIsCalled = false
    func showSubScreen() {
        print(#function)
        coordinatorStartCalled = true

    }
    
    func showNewSubScreenFor() {
        coordinatorStartCalled = true
    }
    
    func showDetailSubScreen(sub: Subscription) {
        self.subscription = sub
        coordinatorStartCalled = true
    }

    var goBackIsCalled = false
    func goBack() {
        goBackIsCalled = true
        print(#function)
    }
    
}

