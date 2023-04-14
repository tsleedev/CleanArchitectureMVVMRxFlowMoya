//  
//  AppInfoUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import RxSwift

public protocol AppInfoUseCaseProtocol {
    func appBundleID() -> Single<String?>
    func appVersion() -> Single<String?>
    func appOSVersion() -> Single<String?>
    func buildVersion() -> Single<String?>
    func deviceType() -> Single<String?>
    func osType() -> Single<String?>
}

public class AppInfoUseCase: DetectDeinit, AppInfoUseCaseProtocol {
    private let repository: AppInfoRepository
    
    public init(repository: AppInfoRepository) {
        self.repository = repository
    }
    
    public func appBundleID() -> Single<String?> {
        return repository.appBundleID()
    }
    
    public func appVersion() -> Single<String?> {
        return repository.appVersion()
    }
    
    public func appOSVersion() -> Single<String?> {
        return repository.appOSVersion()
    }
    
    public func buildVersion() -> Single<String?> {
        return repository.buildVersion()
    }
    
    public func deviceType() -> Single<String?> {
        return repository.deviceType()
    }
    
    public func osType() -> Single<String?> {
        return repository.osType()
    }
}
