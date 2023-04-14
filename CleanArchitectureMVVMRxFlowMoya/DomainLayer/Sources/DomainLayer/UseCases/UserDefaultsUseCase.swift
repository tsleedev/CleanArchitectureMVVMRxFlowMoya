//
//  UserDefaultsUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import RxSwift

public protocol UserDefaultsUseCaseProtocol {
    func uniqueAppInstanceID() -> Single<String?>
    func appVersion() -> Single<String?>
    func deviceName() -> Single<String?>
    func deviceToken() -> Single<String?>
    func osVersion() -> Single<String?>
    func vendorId() -> Single<String?>
}

public class UserDefatulsUseCase: DetectDeinit, UserDefaultsUseCaseProtocol {
    private let repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    public func uniqueAppInstanceID() -> Single<String?> {
        return repository.uniqueAppInstanceID()
    }
    
    public func appVersion() -> Single<String?> {
        return repository.appVersion()
    }
    
    public func deviceName() -> Single<String?> {
        return repository.deviceName()
    }
    
    public func deviceToken() -> Single<String?> {
        return repository.deviceToken()
    }
    
    public func osVersion() -> Single<String?> {
        return repository.osVersion()
    }
    
    public func vendorId() -> Single<String?> {
        return repository.vendorId()
    }
}
