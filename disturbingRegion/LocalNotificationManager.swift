//
//  LocalNotificationManager.swift
//  disturbingRegion
//
//  Created by sayone73 on 02/11/2020.
//  Copyright © 2020 rinoy. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager: NSObject {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
     func didinitiateNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    self.scheduleLocalNotification()
                })
            case .authorized:
                self.scheduleLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
            case .provisional:
                break
            case .ephemeral:
                break
            @unknown default:
                break
            }
        }
    }
    
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(success)
        }
    }
    
    
    private func scheduleLocalNotification() {
        print("here")
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Entered"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.body = "you are in this region"
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval:  0.10, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("here notified local ")
        completionHandler([.alert])
    }
}
