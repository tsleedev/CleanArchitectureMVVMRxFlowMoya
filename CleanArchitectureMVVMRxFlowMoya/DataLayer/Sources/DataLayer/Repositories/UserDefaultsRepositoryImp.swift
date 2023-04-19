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
    
    public var uniqueAppInstanceID: String? {
         get { return service.uniqueAppInstanceID }
         set { service.uniqueAppInstanceID = newValue }
     }
     
     public var appVersion: String? {
         get { return service.appVersion }
         set { service.appVersion = newValue }
     }
     
     public var deviceModel: String? {
         get { return service.deviceModel }
         set { service.deviceModel = newValue }
     }
     
     public var deviceToken: String? {
         get { return service.deviceToken }
         set { service.deviceToken = newValue }
     }
     
     public var osVersion: String? {
         get { return service.osVersion }
         set { service.osVersion = newValue }
     }
     
     public var vendorId: String? {
         get { return service.vendorId }
         set { service.vendorId = newValue }
     }
}
