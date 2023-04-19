//  
//  DeviceRepositoryImp.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import TSCore
import DomainLayer
import RxSwift

public class DeviceRepositoryImp: DetectDeinit, DeviceRepository {
    private let service: DeviceAPIService
    
    public init(service: DeviceAPIService) {
        self.service = service
    }
    
    public func regist(_ param: Params.Device.Regist) -> Single<Entities.Device> {
        let requestModel = RequestModel.Device.Regist(appBundleID: param.appBundleID,
                                                      appVersion: param.appVersion,
                                                      buildVersion: param.buildVersion,
                                                      deviceModel: param.deviceModel,
                                                      deviceType: param.deviceType,
                                                      osType: param.osType,
                                                      osVersion: param.osVersion)
        return service
            .request(.regist(requestModel))
            .map(ResponseModel.DeviceItem.self)
            .map { $0.item.toDomain() }
    }
    
    public func update(_ uniqueAppInstanceID: String, _ param: Params.Device.Update) -> Single<Void> {
        let requestModel = RequestModel.Device.Update(appVersion: param.appVersion,
                                                      buildVersion: param.buildVersion,
                                                      osVersion: param.osVersion)
        return service
            .request(.update(uniqueAppInstanceID: uniqueAppInstanceID, param: requestModel))
            .map { _ in }
    }
    
    public func deviceToken(_ uniqueAppInstanceID: String, _ param: Params.Device.DeviceToken) -> Single<Void> {
        let requestModel = RequestModel.Device.DeviceToken(deviceToken: param.deviceToken)
        return service
            .request(.deviceToken(uniqueAppInstanceID: uniqueAppInstanceID, param: requestModel))
            .map { _ in }
    }
}
