//  
//  NotificationService.swift
//
//
//  Created by TAE SU LEE on 2023/04/27.
//

import TSCore
import Foundation
import RxSwift

public final class NotificationService: DetectDeinit {
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: NotificationUseCaseProtocol

    public init(useCase: NotificationUseCaseProtocol) {
        self.useCase = useCase
    }
    
    public func registerForRemoteNotifications() {
        useCase.registerForRemoteNotifications()
    }
    
    public func requestNotificationAuthorization() -> Single<Bool> {
        return useCase.requestNotificationAuthorization()
    }
    
    public func syncNotification() -> Observable<Entities.Notification> {
        return useCase.syncNotification()
    }
}
