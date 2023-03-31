//
//  AppDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
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
        let networking = HomeNetworking(apiBaseURL: configuration.apiBaseURL,
                                        networkType: makeNetworkType(statusCode: 200, delay: 1))
        let dependencies = HomeSceneDIContainer.Dependencies(networking: networking)
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeSearchSceneDIContainer() -> SearchSceneDIContainer {
        let networking = SearchNetworking(apiBaseURL: configuration.apiBaseURL,
                                          networkType: makeNetworkType(statusCode: 200, delay: 1))
        let dependencies = SearchSceneDIContainer.Dependencies(networking: networking)
        return SearchSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeMoreSceneDIContainer() -> MoreSceneDIContainer {
        let networking = MoreNetworking(apiBaseURL: configuration.apiBaseURL,
                                        networkType: makeNetworkType(statusCode: 200, delay: 1))
        let dependencies = MoreSceneDIContainer.Dependencies(networking: networking)
        return MoreSceneDIContainer(dependencies: dependencies)
    }
    
    public func makeSettingsSceneDIContainer() -> SettingsSceneDIContainer {
        let networking = SettingsNetworking(apiBaseURL: configuration.apiBaseURL,
                                            networkType: makeNetworkType(statusCode: 200, delay: 1))
        let dependencies = SettingsSceneDIContainer.Dependencies(networking: networking)
        return SettingsSceneDIContainer(dependencies: dependencies)
    }
}

// MARK: - Helper
private extension AppDIContainer {
    func makeNetworkType(statusCode: Int, delay: TimeInterval) -> NetworkType {
        let networkType: NetworkType
        switch self.configuration.mode {
        case .useSampleData:
            networkType = .mock(statusCode: statusCode, mockFile: nil, delay: 1)
        case .useRealData:
            networkType = .real
        }
        return networkType
    }
}
