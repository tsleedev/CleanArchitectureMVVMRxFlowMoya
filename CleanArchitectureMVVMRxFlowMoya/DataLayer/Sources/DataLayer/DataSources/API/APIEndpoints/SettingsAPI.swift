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

extension SettingsAPI: MoyaTargetTypeWrapper {
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
        return Data()
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
}
