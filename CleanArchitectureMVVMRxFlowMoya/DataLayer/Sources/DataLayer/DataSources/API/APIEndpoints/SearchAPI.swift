//
//  SearchAPI.swift
//  
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

extension SearchAPI: MoyaTargetTypeWrapper {
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
        return Data()
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
}
