//
//  UserDefaultsService.swift
//  
//
//  Created by TAE SU LEE on 2023/04/13.
//

import TSCore
import Foundation

public final class UserDefaultsService: DetectDeinit {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        super.init()
        setupUserDefaultsWrappers()
    }
    
    @UserDefaultsWrapper(key: "uniqueAppInstanceID", defaultValue: nil)
    var uniqueAppInstanceID: String?
    
    @UserDefaultsWrapper(key: "appVersion", defaultValue: nil)
    var appVersion: String?
    
    @UserDefaultsWrapper(key: "deviceModel", defaultValue: nil)
    var deviceModel: String?
    
    @UserDefaultsWrapper(key: "deviceToken", defaultValue: nil)
    var deviceToken: String?
    
    @UserDefaultsWrapper(key: "osVersion", defaultValue: nil)
    var osVersion: String?
    
    @UserDefaultsWrapper(key: "vendorId", defaultValue: nil)
    var vendorId: String?
    
    private func setupUserDefaultsWrappers() {
        _uniqueAppInstanceID.setUserDefaults(userDefaults)
        _appVersion.setUserDefaults(userDefaults)
        _deviceModel.setUserDefaults(userDefaults)
        _deviceToken.setUserDefaults(userDefaults)
        _osVersion.setUserDefaults(userDefaults)
        _vendorId.setUserDefaults(userDefaults)
    }
}
