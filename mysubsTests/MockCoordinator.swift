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
    
    var coordinatorStartCalled = false
    func start() {
        print(#function)
        coordinatorStartCalled = true
    }

    var showSubScreenIsCalled = false
    func showSubScreen() {
        print(#function)
        coordinatorStartCalled = true

    }
    var showNewSubScreenForIsCalled = false
    func showNewSubScreenFor() {
        showNewSubScreenForIsCalled = true
    }
    
    var subscription: Subscription?
    var showDetailSubScreenIsCalled =  false
    func showDetailSubScreen(sub: Subscription) {
        self.subscription = sub
        showDetailSubScreenIsCalled = true
    }

    var goBackIsCalled = false
    func goBack() {
        goBackIsCalled = true
    }
    
}
