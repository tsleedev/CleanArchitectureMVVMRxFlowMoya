//  
//  AppInfoRepositoryImp.swift
//
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import DomainLayer
import RxSwift

public class AppInfoRepositoryImp: DetectDeinit, AppInfoRepository {
    private let service: AppInfoService
    
    public init(service: AppInfoService) {
        self.service = service
    }
    
    public func appBundleID() -> Single<String?> {
        return .just(service.appBundleID)
    }
    
    public func appVersion() -> Single<String?> {
        return .just(service.appVersion)
    }
    
    public func appOSVersion() -> Single<String?> {
        return .just(service.appOSVersion)
    }
    
    public func buildVersion() -> Single<String?> {
        return .just(service.buildVersion)
    }
    
    public func deviceType() -> Single<String?> {
        return .just(service.deviceType)
    }
    
    public func osType() -> Single<String?> {
        return .just(service.osType)
    }
}
