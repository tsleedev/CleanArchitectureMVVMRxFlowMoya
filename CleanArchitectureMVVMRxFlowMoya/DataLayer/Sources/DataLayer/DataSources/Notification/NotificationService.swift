//
//  NotificationService.swift
//
//
//  Created by TAE SU LEE on 2023/04/20.
//

import TSCore
import TSLogger
import UIKit
import UserNotifications
import RxSwift

public class NotificationService: DetectDeinit {
    // MARK: - Singleton
    public static let shared = NotificationService()
    
    // MARK: - Properties
    let notificationEvent = PublishSubject<[AnyHashable: Any]>()

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    public func requestNotificationAuthorization() -> Single<Bool> {
        return Single<Bool>.create { single in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    TSLogger.error("Error requesting notification authorization: \(error)")
                    single(.failure(error))
                } else {
                    TSLogger.debug("Notification authorization granted: \(granted)")
                    single(.success(granted))
                }
            }
            return Disposables.create()
        }
    }
    
    public func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationService: UNUserNotificationCenterDelegate {
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
            notificationEvent.onNext(userInfo)
        default:
            TSLogger.error("Unknown action")
        }
    }
}
