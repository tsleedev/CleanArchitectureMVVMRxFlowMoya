//  
//  SettingsAPI.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import Foundation
import Moya

public typealias SettingsAPIService = APIService<SettingsAPI>

public enum SettingsAPI {
    case readItems
}

extension SettingsAPI: StatusCodeSampleDataTargetType {
    public var baseURL: URL {
        return URL(string: "about:blank")! // Not used: baseURL is set directly in APIService's initializer
    }
    
    public var path: String {
        switch self {
        case .readItems:
            return "/items"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readItems:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data() // Replaced: Use sampleData(statusCode:) instead
    }
    
    public var task: Moya.Task {
        switch self {
        case .readItems:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .readItems:
            return nil
        }
    }
    
    public func sampleData(statusCode: Int, mockFile: JSONFile?) -> Data {
        if let mockFile = mockFile {
            return JSONLoader.loadJSONFile(mockFile) ?? Data()
        }
        
        switch self {
        case .readItems:
            return JSONLoader.loadJSONFile(JSONFile.settings(statusCode)) ?? Data()
        }
    }
}
