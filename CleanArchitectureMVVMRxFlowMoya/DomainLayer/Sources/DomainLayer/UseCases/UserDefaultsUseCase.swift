//
//  UserDefaultsUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import RxSwift

public protocol UserDefaultsUseCaseProtocol {
    var uniqueAppInstanceID: String? { get set }
    var appVersion: String? { get set }
    var deviceModel: String? { get set }
    var deviceToken: String? { get set }
    var osVersion: String? { get set }
    var vendorId: String? { get set }
}

public class UserDefaultsUseCase: DetectDeinit, UserDefaultsUseCaseProtocol {
    private var repository: UserDefaultsRepository
    
    public init(repository: UserDefaultsRepository) {
        self.repository = repository
    }
    
    public var uniqueAppInstanceID: String? {
         get { return repository.uniqueAppInstanceID }
         set { repository.uniqueAppInstanceID = newValue }
     }
     
     public var appVersion: String? {
         get { return repository.appVersion }
         set { repository.appVersion = newValue }
     }
     
     public var deviceModel: String? {
         get { return repository.deviceModel }
         set { repository.deviceModel = newValue }
     }
     
     public var deviceToken: String? {
         get { return repository.deviceToken }
         set { repository.deviceToken = newValue }
     }
     
     public var osVersion: String? {
         get { return repository.osVersion }
         set { repository.osVersion = newValue }
     }
     
     public var vendorId: String? {
         get { return repository.vendorId }
         set { repository.vendorId = newValue }
     }
}
