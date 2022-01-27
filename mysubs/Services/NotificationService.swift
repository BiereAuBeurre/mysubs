//
//  NotificationService.swift
//  mysubs
//
//  Created by Manon Russo on 26/01/2022.
//

import UserNotifications

class NotificationService: NSObject {
    
    let userNotificationCenter = UNUserNotificationCenter.current()

    func generateNotificationFor(_ name: String, _ reminderValue: Int, _ price: Float, _ date: Date) {
        //for subscription
//        #if DEBUG
//
//        let notificationInterval: Double = 5
//        #else
//
//        let notificationInterval: Double = 5
//        #endif
//

        let date = date.addingTimeInterval(5)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Abonnement \(name )"
        notificationContent.body = "\(reminderValue ) days before payement of \(price ) €"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.userInfo = ["id": "25"]
        notificationContent.categoryIdentifier = "identifier"
        print("trigger date is", trigger.dateComponents)
        let request = UNNotificationRequest(identifier: "42", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("error adding notification \(error)")
            } else {
                print("notification added success")
            }
        }
    }
}


