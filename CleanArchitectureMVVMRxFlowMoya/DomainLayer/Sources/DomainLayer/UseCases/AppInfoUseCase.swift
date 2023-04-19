//  
//  AppInfoUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import RxSwift

public protocol AppInfoUseCaseProtocol {
    func appBundleID() -> String
    func appVersion() -> String
    func buildVersion() -> String
    func deviceModel() -> String
    func deviceType() -> String
    func osType() -> String
    func osVersion() -> String
}

public class AppInfoUseCase: DetectDeinit, AppInfoUseCaseProtocol {
    private let repository: AppInfoRepository
    
    public init(repository: AppInfoRepository) {
        self.repository = repository
    }
    
    public func appBundleID() -> String {
        return repository.appBundleID()
    }
    
    public func appVersion() -> String {
        return repository.appVersion()
    }
    
    public func buildVersion() -> String {
        return repository.buildVersion()
    }
    
    public func deviceModel() -> String {
        return repository.deviceModel()
    }
    
    public func deviceType() -> String {
        return repository.deviceType()
    }
    
    public func osType() -> String {
        return repository.osType()
    }
    
    public func osVersion() -> String {
        return repository.osVersion()
    }
}
