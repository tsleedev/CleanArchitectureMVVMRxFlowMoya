//  
//  HomeAPI.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import Foundation
import Moya

public typealias HomeAPIService = APIService<HomeAPI>

public enum HomeAPI {
//    case readItems
//    case readItem
}

extension HomeAPI: StatusCodeSampleDataTargetType {
    public var baseURL: URL {
        return URL(string: "about:blank")! // Not used: baseURL is set directly in APIService's initializer
    }
    
    public var path: String {
//        switch self {
//        case .readItems:
//            return "/items"
//        case .readItem:
//            return "/item"
//        }
        return ""
    }
    
    public var method: Moya.Method {
//        switch self {
//        case .readItems, .readItem:
//            return .get
//        }
        return .get
    }
    
    public var sampleData: Data {
        return Data() // Replaced: Use sampleData(statusCode:) instead
    }
    
    public var task: Moya.Task {
//        switch self {
//        case .readItems, .readItem:
//            return .requestPlain
//        }
        return .requestPlain
    }
    
    public var headers: [String: String]? {
//        switch self {
//        case .readItems, .readItem:
//            return .nil
//        }
        return nil
    }
    
    public func sampleData(statusCode: Int, mockFile: JSONFile?) -> Data {
        if let mockFile = mockFile {
            return JSONLoader.loadJSONFile(mockFile) ?? Data()
        }
        
        return JSONLoader.loadJSONFile(JSONFile.home(statusCode)) ?? Data()
    }
}
