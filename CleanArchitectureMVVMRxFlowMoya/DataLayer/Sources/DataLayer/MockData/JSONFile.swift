//
//  JSONFile.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

public enum JSONFile {
    case deviceRegist(Int)
    case deviceUpdate(Int)
    case deviceDeviceToken(Int)
    case home(Int)
    case more(Int)
    case search(Int)
    case searchNoItems
    case settings(Int)
}

public extension JSONFile {
    enum Device {
        case deviceRegist200
    }
    
    enum Search {
        case readItemsNoItems
        case readItems200
        case readItems403
    }
    
    enum More {
        case readItems200
    }
    
    enum Settings {
        case readItems200
    }
}

extension JSONFile.Device: JSONLoader {
    public var resource: String {
        switch self {
        case .deviceRegist200:
            return "DeviceRegistSampleDataStatusCode200"
        }
    }
}

extension JSONFile.Search: JSONLoader {
    public var resource: String {
        switch self {
        case .readItemsNoItems:
            return "SearchSampleDataNoItemsStatusCode200"
        case .readItems200:
            return "SearchSampleDataStatusCode200"
        case .readItems403:
            return "SearchSampleDataStatusCode403"
        }
    }
}

extension JSONFile.More: JSONLoader {
    public var resource: String {
        switch self {
        case .readItems200:
            return "MoreSampleDataStatusCode200"
        }
    }
}

extension JSONFile.Settings: JSONLoader {
    public var resource: String {
        switch self {
        case .readItems200:
            return "SettingsSampleDataStatusCode200"
        }
    }
}
