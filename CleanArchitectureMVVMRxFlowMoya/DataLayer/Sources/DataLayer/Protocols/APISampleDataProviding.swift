//
//  APISampleDataProviding.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

public protocol APISampleDataProviding {
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData?
}

public struct APISampleData: SampleDataUsable {
    let statusCode: Int
    let delay: TimeInterval
    let jsonLoader: JSONLoader?
    
    public init(statusCode: Int, delay: TimeInterval, jsonLoader: JSONLoader?) {
        self.statusCode = statusCode
        self.delay = delay
        self.jsonLoader = jsonLoader
    }
}
