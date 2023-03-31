//
//  AppConfiguration.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import Foundation

public enum EnvironmentMode {
    case useSampleData
    case useRealData
}

public enum EnvironmentTarget {
    case dev
    case stg
    case prod
    
    var apiBaseURL: String {
        switch self {
        case .dev:  return "https://api-debug.example.com"
        case .stg:  return "https://api-test.example.com"
        case .prod: return "https://api-production.example.com"
        }
    }
    
    // Define additional requirements if needed
}

public struct AppConfiguration {
    let mode: EnvironmentMode
    let apiBaseURL: URL
    
    public init(mode: EnvironmentMode, target: EnvironmentTarget) {
        self.mode = mode
        self.apiBaseURL = URL(string: target.apiBaseURL)!
    }
}
