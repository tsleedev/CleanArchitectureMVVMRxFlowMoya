//  
//  Params+Device.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import Foundation

public extension Params {
    struct Device { }
}

public extension Params.Device {
    struct Regist {
        public let appBundleID: String
        public let appVersion: String
        public let buildVersion: String
        public let deviceModel: String
        public let deviceType: String
        public let osType: String
        public let osVersion: String
    }
    
    struct Update {
        public let appVersion: String
        public let buildVersion: String
        public let osVersion: String
    }
    
    struct DeviceToken {
        public let deviceToken: String
    }
}
