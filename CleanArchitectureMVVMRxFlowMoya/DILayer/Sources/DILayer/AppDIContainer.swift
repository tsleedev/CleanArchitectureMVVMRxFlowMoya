//
//  AppDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import DataLayer
import Foundation

public final class AppDIContainer {
    private let configuration: AppConfiguration
    
    public init(configuration: AppConfiguration) {
        self.configuration = configuration
    }
    
    public func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        let service = HomeAPIService(apiBaseURL: configuration.apiBaseURL,
                                     apiType: makeAPIType(statusCode: 200, delay: 1))
        let dependencies = HomeSceneDIContainer.Dependencies(service: service)
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeSearchSceneDIContainer() -> SearchSceneDIContainer {
        let service = SearchAPIService(apiBaseURL: configuration.apiBaseURL,
                                       apiType: makeAPIType(statusCode: 200, delay: 1))
        let dependencies = SearchSceneDIContainer.Dependencies(service: service)
        return SearchSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeMoreSceneDIContainer() -> MoreSceneDIContainer {
        let service = MoreAPIService(apiBaseURL: configuration.apiBaseURL,
                                     apiType: makeAPIType(statusCode: 200, delay: 1))
        let dependencies = MoreSceneDIContainer.Dependencies(service: service)
        return MoreSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeSettingsSceneDIContainer() -> SettingsSceneDIContainer {
        let service = SettingsAPIService(apiBaseURL: configuration.apiBaseURL,
                                         apiType: makeAPIType(statusCode: 200, delay: 1))
        let dependencies = SettingsSceneDIContainer.Dependencies(service: service)
        return SettingsSceneDIContainer(dependencies: dependencies)
    }
}

// MARK: - Helper
private extension AppDIContainer {
    func makeAPIType(statusCode: Int, delay: TimeInterval) -> APIType {
        let apiType: APIType
        switch self.configuration.mode {
        case .useSampleData:
            apiType = .mock(statusCode: statusCode, mockFile: nil, delay: 1)
        case .useRealData:
            apiType = .real
        }
        return apiType
    }
}
