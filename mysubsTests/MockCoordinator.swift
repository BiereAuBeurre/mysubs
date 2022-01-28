//
//  MockCoordinator.swift
//  mysubsTests
//
//  Created by Manon Russo on 28/01/2022.
//

import Foundation
import UIKit
@testable import mysubs

class CoordinatorMock: AppCoordinator {
    
    var coordinatorStartCalled = false
    
    override func start() {
            coordinatorStartCalled = true
    }
//    var navigationController: UINavigationController
    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
    
}


