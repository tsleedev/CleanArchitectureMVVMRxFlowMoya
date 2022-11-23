//
//  APIError.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Foundation

public struct APIErrorResponse: Decodable {
    public let message: String
}

public enum APIError: Error {
    case notFound
    case with(message: String)
    
    public init(stautsCode: Int, message: String) {
        switch stautsCode {
        case 404:
            self = .notFound
        default:
            self = .with(message: message)
        }
    }
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "API notFound"
        case .with(let message):
            return message
        }
    }
}
