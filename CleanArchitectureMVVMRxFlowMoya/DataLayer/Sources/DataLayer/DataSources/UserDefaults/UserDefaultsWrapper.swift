//
//  UserDefaultsWrapper.swift
//  
//
//  Created by TAE SU LEE on 2023/04/13.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    private let key: String
    private let defaultValue: T?
    private(set) var userDefaults: UserDefaults
    
    init(key: String, defaultValue: T?, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    var wrappedValue: T? {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    mutating func setUserDefaults(_ newUserDefaults: UserDefaults) {
        self.userDefaults = newUserDefaults
    }
}
