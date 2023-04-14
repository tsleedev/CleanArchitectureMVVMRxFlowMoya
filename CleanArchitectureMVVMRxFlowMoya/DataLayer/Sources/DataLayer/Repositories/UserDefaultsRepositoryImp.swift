//  
//  UserDefaultsRepositoryImp.swift
//
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import DomainLayer
import RxSwift

public class UserDefaultsRepositoryImp: DetectDeinit, UserDefaultsRepository {
    private let service: UserDefaultsService
    
    public init(service: UserDefaultsService) {
        self.service = service
    }
    
    public func uniqueAppInstanceID() -> Single<String?> {
        return .just(service.uniqueAppInstanceID)
    }
    
    public func appVersion() -> Single<String?> {
        return .just(service.appVersion)
    }
    
    public func deviceName() -> Single<String?> {
        return .just(service.deviceName)
    }
    
    public func deviceToken() -> Single<String?> {
        return .just(service.deviceToken)
    }
    
    public func osVersion() -> Single<String?> {
        return .just(service.osVersion)
    }
    
    public func vendorId() -> Single<String?> {
        return .just(service.vendorId)
    }
}
