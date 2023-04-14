//
//  UserDefaultsService.swift
//  
//
//  Created by TAE SU LEE on 2023/04/13.
//

import Foundation

public final class UserDefaultsService {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        setupUserDefaultsWrappers()
    }
    
    @UserDefaultsWrapper(key: "uniqueAppInstanceID", defaultValue: nil)
    var uniqueAppInstanceID: String?
    
    @UserDefaultsWrapper(key: "appVersion", defaultValue: nil)
    var appVersion: String?
    
    @UserDefaultsWrapper(key: "deviceName", defaultValue: nil)
    var deviceName: String?
    
    @UserDefaultsWrapper(key: "deviceToken", defaultValue: nil)
    var deviceToken: String?
    
    @UserDefaultsWrapper(key: "osVersion", defaultValue: nil)
    var osVersion: String?
    
    @UserDefaultsWrapper(key: "vendorId", defaultValue: nil)
    var vendorId: String?
    
    private func setupUserDefaultsWrappers() {
        _uniqueAppInstanceID.setUserDefaults(userDefaults)
        _appVersion.setUserDefaults(userDefaults)
        _deviceName.setUserDefaults(userDefaults)
        _deviceToken.setUserDefaults(userDefaults)
        _osVersion.setUserDefaults(userDefaults)
        _vendorId.setUserDefaults(userDefaults)
    }
}
