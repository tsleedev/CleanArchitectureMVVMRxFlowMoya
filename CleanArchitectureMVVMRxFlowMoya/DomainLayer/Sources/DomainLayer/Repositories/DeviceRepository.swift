//  
//  DeviceRepository.swift
//
//
//  Created by TAE SU LEE on 2023/04/18.
//

import RxSwift

public protocol DeviceRepository {
    func regist(_ param: Params.Device.Regist) -> Single<Entities.Device>
    func update(_ uniqueAppInstanceID: String, _ param: Params.Device.Update) -> Single<Void>
    func deviceToken(_ uniqueAppInstanceID: String, _ param: Params.Device.DeviceToken) -> Single<Void>
}
