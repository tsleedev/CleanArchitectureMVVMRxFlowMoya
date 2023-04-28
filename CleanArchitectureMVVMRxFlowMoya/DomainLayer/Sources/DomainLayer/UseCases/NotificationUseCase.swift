//  
//  NotificationUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/27.
//

import TSCore
import RxSwift

public protocol NotificationUseCaseProtocol {
    func registerForRemoteNotifications()
    func requestNotificationAuthorization() -> Single<Bool>
    func syncNotification() -> Observable<Entities.Notification>
}

public class NotificationUseCase: DetectDeinit, NotificationUseCaseProtocol {
    private let repository: NotificationRepository
    
    public init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    public func registerForRemoteNotifications() {
        repository.registerForRemoteNotifications()
    }
    
    public func requestNotificationAuthorization() -> Single<Bool> {
        return repository.requestNotificationAuthorization()
    }
    
    public func syncNotification() -> Observable<Entities.Notification> {
        return repository.syncNotification()
    }
}
