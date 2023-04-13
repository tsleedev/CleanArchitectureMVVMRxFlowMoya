//
//  APIService.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import Foundation
import Moya
import RxMoya
import RxSwift

public enum APIType {
    case real
    case mock(statusCode: Int = 200, mockFile: JSONFile?, delay: TimeInterval = 0)
}

public final class APIService<Target: StatusCodeSampleDataTargetType> {
    private let provider: MoyaProvider<Target>
    
    public init(apiBaseURL: URL, apiType: APIType = .real) {
        let plugin = APILogPlugin()
        let endpointClosure = { (target: Target) -> Endpoint in
            let url = apiBaseURL.appendingPathComponent(target.path).absoluteString
            let sampleResponseClosure: EndpointSampleResponse
            switch apiType {
            case .real:
                sampleResponseClosure = .networkResponse(200, target.sampleData)
            case .mock(let statusCode, let mockFile,  _):
                sampleResponseClosure = .networkResponse(statusCode, target.sampleData(statusCode: statusCode, mockFile: mockFile))
            }
            return Endpoint(url: url,
                            sampleResponseClosure: { sampleResponseClosure },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        switch apiType {
        case .real:
            provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                            plugins: [plugin])
        case .mock(_, _, let delay):
            provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                            stubClosure: delay == 0 ? MoyaProvider.immediatelyStub : MoyaProvider.delayedStub(delay),
                                            plugins: [plugin])
        }
    }
    
    public func request(_ target: Target) -> Single<Response> {
        return provider.rx.request(target)
            .catchAPIError(APIErrorResponse.self)
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func catchAPIError(_ type: APIErrorResponse.Type) -> Single<Element> {
        return flatMap { response in
            if (200...299) ~= response.statusCode {
                return Single.just(response)
            }
            
            do {
                let error = try response.map(type.self)
                throw APIError(stautsCode: response.statusCode, message: error.message)
            } catch {
                throw error
            }
        }
    }
}
