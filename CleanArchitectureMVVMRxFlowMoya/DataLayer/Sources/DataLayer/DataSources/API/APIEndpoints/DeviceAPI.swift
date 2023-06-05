//  
//  DeviceAPI.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import TSCore
import Foundation
import Moya

public typealias DeviceAPIService = APIService<DeviceAPI>

public enum DeviceAPI {
    case regist(RequestModel.Device.Regist)
    case update(uniqueAppInstanceID: String, param: RequestModel.Device.Update)
    case deviceToken(uniqueAppInstanceID: String, param: RequestModel.Device.DeviceToken)
}

extension DeviceAPI: MoyaTargetTypeWrapper {
    public var baseURL: URL {
        return URL(string: "about:blank")! // Not used: baseURL is set directly in APIService's initializer
    }
    
    public var path: String {
        switch self {
        case .regist:
            return "/api/device"
        case .update(let uniqueAppInstanceID, _),
                .deviceToken(let uniqueAppInstanceID, _):
            return "/api/device/\(uniqueAppInstanceID)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .regist:
            return .post
        case .update, .deviceToken:
            return .patch
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Moya.Task {
        switch self {
        case .regist(let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: JSONEncoding.default)
        case .update(_, let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: JSONEncoding.default)
        case .deviceToken(_, let param):
            return .requestParameters(parameters: param.toDictionary(), encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
//        switch self {
//        case .readItems, .readItem:
//            return nil
//        }
        return nil
    }
}
