//  
//  DeviceUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import TSCore
import RxSwift

public protocol DeviceUseCaseProtocol {
    func regist(_ param: Params.Device.Regist) -> Single<Entities.Device>
    func update(_ uniqueAppInstanceID: String, _ param: Params.Device.Update) -> Single<Void>
    func deviceToken(_ uniqueAppInstanceID: String, _ param: Params.Device.DeviceToken) -> Single<Void>
}

public class DeviceUseCase: DetectDeinit, DeviceUseCaseProtocol {
    private let repository: DeviceRepository
    
    public init(repository: DeviceRepository) {
        self.repository = repository
    }
    
    public func regist(_ param: Params.Device.Regist) -> Single<Entities.Device> {
        return repository.regist(param)
    }
    
    public func update(_ uniqueAppInstanceID: String, _ param: Params.Device.Update) -> Single<Void> {
        return repository.update(uniqueAppInstanceID, param)
    }
    
    public func deviceToken(_ uniqueAppInstanceID: String, _ param: Params.Device.DeviceToken) -> Single<Void> {
        return repository.deviceToken(uniqueAppInstanceID, param)
    }
}
