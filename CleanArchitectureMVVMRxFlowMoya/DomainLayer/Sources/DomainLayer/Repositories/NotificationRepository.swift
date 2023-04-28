//  
//  NotificationRepository.swift
//  
//
//  Created by TAE SU LEE on 2023/04/27.
//

import RxSwift

public protocol NotificationRepository {
    func registerForRemoteNotifications()
    func requestNotificationAuthorization() -> Single<Bool>
    func syncNotification() -> Observable<Entities.Notification>
    
    // Defines methods to be added later
//    func getNotificationSettings() -> Observable<NotificationSettings> // Fetch notification settings
//    func updateNotificationSettings(_ settings: NotificationSettings) -> Completable // Update notification settings
//    func getNotifications() -> Single<[Entities.Notification]> // Fetch notifications list
}
