//
//  NotificationManager.swift
//
//
//  Created by TAE SU LEE on 2023/04/20.
//

import TSCore
import TSLogger
import PresentationLayer
import UIKit
import UserNotifications

public class NotificationManager: DetectDeinit { // , NotificationRepository {
    public static let shared = NotificationManager()
    
    private override init() {
        super.init()
    }
    
    public func initialize() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    public func requestNotificationAuthorization(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                TSLogger.debug("Error requesting notification authorization: \(error)")
                completion?(false)
            } else {
                TSLogger.debug("Notification authorization granted: \(granted)")
                completion?(granted)
            }
        }
    }
    
    public func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if #available(iOS 14.0, *) {
            return [.banner, .sound]
        } else {
            return [.alert, .sound]
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let notification = response.notification
        let userInfo = notification.request.content.userInfo
        let actionIdentifier = response.actionIdentifier
        
        switch actionIdentifier {
        case UNNotificationDefaultActionIdentifier: // Handling when the user taps on a notification
            DispatchQueue.main.async {
                self.handleNotification(userInfo: userInfo)
            }
        default:
            TSLogger.error("Unknown action")
        }
    }
}

// MARK: - Helper
private extension NotificationManager {
    func handleNotification(userInfo: [AnyHashable: Any]) {
        Application.shared.navigate(to: DeepLinkStep.settings, closeAllViewController: false)
    }
}
