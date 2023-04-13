//
//  SearchAPI.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import Foundation
import Moya

public typealias SearchAPIService = APIService<SearchAPI>

public enum SearchAPI {
    case readItems(RequestModel.Search)
}

extension SearchAPI: StatusCodeSampleDataTargetType {
    public var baseURL: URL {
        return URL(string: "about:blank")! // Not used: baseURL is set directly in APIService's initializer
    }
    
    public var path: String {
        switch self {
        case .readItems:
            return "/search/repositories"
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
        case .readItems(let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: URLEncoding.default)
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
            return JSONLoader.loadJSONFile(JSONFile.search(statusCode)) ?? Data()
        }
    }
}
