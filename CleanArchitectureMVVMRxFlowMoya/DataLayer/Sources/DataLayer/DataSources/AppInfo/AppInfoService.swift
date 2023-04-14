//
//  AppInfoService.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import TSCore
import UIKit

public class AppInfoService {
    public var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    public var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0" // "1.2.3"
    }
    
    public var appOSVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public var buildVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
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
}
