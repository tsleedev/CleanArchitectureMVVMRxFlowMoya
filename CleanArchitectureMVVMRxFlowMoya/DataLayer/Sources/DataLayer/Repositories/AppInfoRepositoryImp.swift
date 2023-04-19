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
    
    public func appBundleID() -> String {
        return service.appBundleID
    }
    
    public func appVersion() -> String {
        return service.appVersion
    }
    
    public func buildVersion() -> String {
        return service.buildVersion
    }
    
    public func deviceModel() -> String {
        return service.deviceModelIdentifier
    }
    
    public func deviceType() -> String {
        return service.deviceType
    }
    
    public func osType() -> String {
        return service.osType
    }
    
    public func osVersion() -> String {
        return service.osVersion
    }
}
