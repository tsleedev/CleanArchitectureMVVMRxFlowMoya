//
//  RepoAPI.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Foundation
import Moya

public enum RepoAPI {
    case searchRepos(query: String, page: Int, perPage: Int)
}

extension RepoAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .searchRepos:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .searchRepos:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .searchRepos:
            return SampleData().searchRepos
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .searchRepos(let query, let page, let perPage):
            let parameters: [String: Any] = [
                "q": query,
                "page": page,
                "per_page": perPage
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .searchRepos:
            return nil
        }
    }    
}
