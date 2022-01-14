//
//  Notifications.swift
//  mysubs
//
//  Created by Manon Russo on 13/01/2022.
//

//import Foundation
//import UIKit
//
//class MyNotification {
//// Notification center property
//let userNotificationCenter = UNUserNotificationCenter.current()
//
//func requestNotificationAuthorization() {
//    // Code here
//}
//
//func sendNotification() {
//    // Code here
//}
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    self.requestNotificationAuthorization()
//    self.sendNotification()
//}
//
//    // Auth options
//    let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
//
//    self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//        if let error = error {
//            print("Error: ", error)
//        }
//    }
//
//    func requestNotificationAuthorization() {
//        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
//
//        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//            if let error = error {
//                print("Error: ", error)
//            }
//        }
//    }
//
//}
//
