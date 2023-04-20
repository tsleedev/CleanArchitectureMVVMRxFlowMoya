//
//  NotificationManager.swift
//
//
//  Created by TAE SU LEE on 2023/04/20.
//

import TSCore
import UIKit
import UserNotifications

public class NotificationManager: DetectDeinit { // , NotificationRepository {
    public static let shared = NotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    public func initialize() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    public func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
                completion(false)
            } else {
                print("Notification authorization granted: \(granted)")
                completion(granted)
            }
        }
    }
    
    public func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if #available(iOS 14.0, *) {
            return [.banner, .sound]
        } else {
            return [.alert, .sound]
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        
    }
}
