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

public final class APIService<Target: MoyaTargetTypeWrapper>: DetectDeinit {
    private let provider: MoyaProvider<Target>
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        return Session(configuration: configuration, startRequestsImmediately: false)
    }()
    
    public init(apiBaseURL: URL, sampleData: APISampleDataProviding?) {
        let plugin = APILogPlugin()
        let endpointClosure = { (target: Target) -> Endpoint in
            let url = apiBaseURL.appendingPathComponent(target.path).absoluteString
            let sampleResponseClosure: EndpointSampleResponse
            if let sampleData = sampleData?.provideAPISampleData(forEndpoint: target) {
                sampleResponseClosure = .networkResponse(sampleData.statusCode, sampleData.getSampleData(sampleData.jsonLoader) ?? target.sampleData)
            } else {
                sampleResponseClosure = .networkResponse(200, target.sampleData)
            }
            return Endpoint(url: url,
                            sampleResponseClosure: { sampleResponseClosure },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let stubClosure: MoyaProvider<Target>.StubClosure = { (target: Target) in
            if let sampleData = sampleData?.provideAPISampleData(forEndpoint: target) {
                return sampleData.delay > 0 ? .delayed(seconds: sampleData.delay) : .immediate
            } else {
                return .never
            }
        }
        
        provider = MoyaProvider<Target>(endpointClosure: endpointClosure,
                                        stubClosure: stubClosure,
                                        plugins: [plugin])
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
