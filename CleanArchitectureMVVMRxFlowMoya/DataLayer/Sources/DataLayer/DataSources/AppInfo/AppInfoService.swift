//
//  AppInfoService.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import UIKit

public class AppInfoService: DetectDeinit {
    public var appBundleID: String {
        return Bundle.main.bundleIdentifier ?? "unknown"
    }
    
    public var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0" // "1.2.3"
    }
    
    public var buildVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
    
    public var deviceModelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelIdentifierData = Data(bytes: &systemInfo.machine, count: Int(_SYS_NAMELEN))
        
        if let modelIdentifier = String(bytes: modelIdentifierData, encoding: .utf8) {
            return modelIdentifier.trimmingCharacters(in: .controlCharacters)
        }
        
        return "unknown"
    }
    
    public var deviceType: String {
        switch UIDevice.current.userInterfaceIdiom {
        case .unspecified:
            return "unspecified"
        case .phone:
            return "phone"
        case .pad:
            return "pad"
        case .tv:
            return "tv"
        case .carPlay:
            return "carPlay"
        case .mac:
            return "mac"
        @unknown default:
            return "unknown"
        }
    }
    
    public var osType: String {
        return Constants.osType
    }
    
    public var osVersion: String {
        return UIDevice.current.systemVersion
    }
}
