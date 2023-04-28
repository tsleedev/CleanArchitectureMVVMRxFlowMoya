//  
//  ResponseModel+Device.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct DeviceItems: Decodable {
        let items: [Device]
    }
    
    struct DeviceItem: Decodable {
        let item: Device
    }
    
    struct Device: Decodable {
        let uniqueAppInstanceID: String
    }
}

extension ResponseModel.Device {
    func toDomain() -> Entities.Device {
        return .init(uniqueAppInstanceID: uniqueAppInstanceID)
    }
}
