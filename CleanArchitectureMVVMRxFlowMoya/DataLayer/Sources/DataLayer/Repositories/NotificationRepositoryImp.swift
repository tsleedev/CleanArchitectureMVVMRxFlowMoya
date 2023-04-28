//  
//  NotificationRepositoryImp.swift
//  
//
//  Created by TAE SU LEE on 2023/04/27.
//

import TSCore
import DomainLayer
import Foundation
import RxSwift

public class NotificationRepositoryImp: DetectDeinit, NotificationRepository {
    private let service = NotificationService.shared
    
    public func registerForRemoteNotifications() {
        service.registerForRemoteNotifications()
    }
    
    public func requestNotificationAuthorization() -> Single<Bool> {
        return service.requestNotificationAuthorization()
    }
    
    public func syncNotification() -> Observable<Entities.Notification> {
        return service.notificationEvent
            .flatMap { userInfo -> Observable<ResponseModel.Notification> in
                guard let data = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else {
                    return Observable.empty()
                }
                return Observable.just(try JSONDecoder().decode(ResponseModel.Notification.self, from: data))
            }
            .map { $0.toDomain() }
    }
}
