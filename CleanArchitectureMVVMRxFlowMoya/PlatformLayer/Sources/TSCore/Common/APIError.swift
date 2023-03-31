//
//  APIError.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Foundation

public struct APIErrorResponse: Decodable {
    public let message: String
}

public enum APIError: Error {
    case unknown
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
        case .unknown:
            return "API unknown error"
        case .notFound:
            return "API notFound"
        case .with(let message):
            return message
        }
    }
}

extension APIError: Equatable {
    public static func ==(lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
            (.notFound, .notFound):
            return true
        case (.with(let lmsg), .with(let rmsg)):
            return lmsg == rmsg
        default:
            return false
        }
    }
}
