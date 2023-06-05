//  ___FILEHEADER___

import TSCore
import Foundation
import Moya

public typealias ___VARIABLE_productName:identifier___APIService = APIService<___VARIABLE_productName:identifier___API>

public enum ___VARIABLE_productName:identifier___API {
//    case readItems
//    case readItem
}

extension ___VARIABLE_productName:identifier___API: MoyaTargetTypeWrapper {
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
        return Data()
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
//            return nil
//        }
        return nil
    }
}
