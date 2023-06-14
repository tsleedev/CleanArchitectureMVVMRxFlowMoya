//
//  APISampleDataProviding.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

public protocol APISampleDataProviding {
    var mockData: [String: Data?]? { get }
    func provideAPISampleData(forEndpoint endpoint: any MoyaTargetTypeWrapper) -> APISampleData?
}

public struct APISampleData {
    let statusCode: Int
    let delay: TimeInterval
    let sampleData: Data?
    
    public init(statusCode: Int, delay: TimeInterval, sampleData: Data?) {
        self.statusCode = statusCode
        self.delay = delay
        self.sampleData = sampleData
    }
}
