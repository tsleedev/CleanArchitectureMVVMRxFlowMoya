//
//  SampleDataProviding.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

public protocol SampleDataProviding {
    func provideSampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> SampleData?
}

public struct SampleData {
    let statusCode: Int
    let delay: TimeInterval
    let jsonLoader: JSONLoader?
    
    public init(statusCode: Int, delay: TimeInterval, jsonLoader: JSONLoader?) {
        self.statusCode = statusCode
        self.delay = delay
        self.jsonLoader = jsonLoader
    }
}

extension SampleData {
    func getSampleData(_ jsonLoader: JSONLoader?) -> Data? {
        guard let jsonLoader = jsonLoader else { return nil }
        return jsonLoader.load(jsonLoader)
    }
}
