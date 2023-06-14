//
//  AppConfiguration.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import DataLayer
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
    let mockData: [String: Data?]?
    
    public init(mode: EnvironmentMode, target: EnvironmentTarget) {
        self.mode = mode
        self.apiBaseURL = URL(string: target.apiBaseURL)!
        self.mockData = nil
    }
    
    // 미리보기용 초기화 메서드
    public init(forPreviewWithTarget target: EnvironmentTarget, mockData: [String: Data?]? = nil) {
        self.mode = .useSampleData
        self.apiBaseURL = URL(string: target.apiBaseURL)!
        self.mockData = mockData
    }
}
