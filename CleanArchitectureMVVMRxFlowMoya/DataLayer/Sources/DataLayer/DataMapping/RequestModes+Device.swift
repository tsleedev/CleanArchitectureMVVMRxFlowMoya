//  
//  RequestModes+Device.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import Foundation

public extension RequestModel {
    struct Device { }
}

public extension RequestModel.Device {
    struct Regist: Encodable {
        let appBundleID: String
        let appVersion: String
        let buildVersion: String
        let deviceModel: String
        let deviceType: String
        let osType: String
        let osVersion: String
    }
    
    struct Update: Encodable {
        let appVersion: String
        let buildVersion: String
        let osVersion: String
    }
    
    struct DeviceToken: Encodable {
        let deviceToken: String
    }
}
