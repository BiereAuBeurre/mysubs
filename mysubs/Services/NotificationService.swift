//
//  NotificationService.swift
//  mysubs
//
//  Created by Manon Russo on 26/01/2022.
//

import UserNotifications

// struct ? ou final class
class NotificationService {
    
    let userNotificationCenter = UNUserNotificationCenter.current()

    func cancelnotif(for notificationId: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
    func cancelAllNotif() {
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    static func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
            if isGranted {
                print("Notification permission was granted")
            }
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            }
        }
    }
    
    static func shouldRequestNotificationAuthorization(_ completion: @escaping ((Bool) -> Void)) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isNotAuthorized = (settings.authorizationStatus == .notDetermined)
            completion(isNotAuthorized)
        }
    }
    
    func generateNotificationFor(_ name: String, _ reminderValue: Int, _ price: Float, _ date: Date) {
       
//        #if DEBUG
//        let notificationInterval: Double = 5
//        let date = date.addingTimeInterval(notificationInterval)
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

//        #else
//        let notificationInterval: Double = 5
//        let date = date.addingTimeInterval(notificationInterval)
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        dateComponents.hour = 9
//        dateComponents.minute = 0
//        dateComponents.second = 0
//        #endif
        
//        let date = date.addingTimeInterval(notificationInterval)
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        dateComponents.hour = 9
//        dateComponents.minute = 0
//        dateComponents.second = 0
        let notificationInterval: Double = 13
        let date = date.addingTimeInterval(notificationInterval)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Abonnement \(name)"
        notificationContent.body = "\(reminderValue) days before payement of \(price) €"
        notificationContent.sound = UNNotificationSound.default
//        notificationContent.userInfo = ["id": "25"]
//        notificationContent.categoryIdentifier = "identifier"
        print("trigger date is", trigger.dateComponents)
        //changer pour un identifiant unique
        let request = UNNotificationRequest(identifier: "42", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("error adding notification \(error)")
            } else {
                print("notification added success")
            }
        }
    }
    
    func addNotificationRquest(_ request: UNNotificationRequest) {
        
    }
}


