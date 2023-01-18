//
//  Networking.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import Foundation
import Moya
import RxMoya
import RxSwift

public typealias RepoNetworking = Networking<RepoAPI>

public enum NetworkType {
    case none
    case sample(statusCode: Int = 200)
    case error
}

final public class Networking<Target: TargetType> {
    private let provider: MoyaProvider<Target>
    
    public init(networkType: NetworkType = .none, delayed seconds: TimeInterval = 0) {
        let plugin = NetworkLogPlugin()
        switch networkType {
        case .none:
            provider = MoyaProvider<Target>(plugins: [plugin])
        case .sample(let statusCode):
            let endpointClosure = { (target: TargetType) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(statusCode, target.sampleData) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                            stubClosure: seconds == 0 ? MoyaProvider.immediatelyStub : MoyaProvider.delayedStub(seconds),
                                            plugins: [plugin])
        case .error:
            let endpointClosure = { (target: TargetType) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(403, SampleData().error) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                            stubClosure: seconds == 0 ? MoyaProvider.immediatelyStub : MoyaProvider.delayedStub(seconds),
                                            plugins: [plugin])
        }
    }
    
    public func request(_ target: Target) -> Single<Response> {
        return provider.rx.request(target)
            .catchAPIError(APIErrorResponse.self)
            .filterSuccessfulStatusCodes()
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
