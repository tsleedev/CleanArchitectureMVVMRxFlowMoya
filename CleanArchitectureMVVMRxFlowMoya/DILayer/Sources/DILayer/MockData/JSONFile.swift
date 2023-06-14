//
//  JSONFile.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

public protocol JSONFileRepresentable {
    var fileName: String { get }
    var sampleData: Data? { get }
}

public enum JSONFile { }

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
        case readNoItem200
    }
    
    enum Settings {
        case readItems200
    }
}

extension JSONFile.Device: JSONFileRepresentable {
    public var fileName: String {
        switch self {
        case .deviceRegist200:
            return "DeviceRegistSampleDataStatusCode200"
        }
    }
    
    public var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.Search: JSONFileRepresentable {
    public var fileName: String {
        switch self {
        case .readItemsNoItems:
            return "SearchSampleDataNoItemsStatusCode200"
        case .readItems200:
            return "SearchSampleDataStatusCode200"
        case .readItems403:
            return "SearchSampleDataStatusCode403"
        }
    }
    
    public var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.More: JSONFileRepresentable {
    public var fileName: String {
        switch self {
        case .readItems200:
            return "MoreSampleDataStatusCode200"
        case .readNoItem200:
            return "MoreSampleDataNoItemStatusCode200"
        }
    }
    
    public var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.Settings: JSONFileRepresentable {
    public var fileName: String {
        switch self {
        case .readItems200:
            return "SettingsSampleDataStatusCode200"
        }
    }
    
    public var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}
