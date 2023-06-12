//
//  SceneDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import DataLayer
import Foundation

public final class SceneDIContainer {
    private let configuration: AppConfiguration
    
    public init(configuration: AppConfiguration) {
        self.configuration = configuration
    }
}

// MARK: - MakeDIContainer
public extension SceneDIContainer {
    func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        let service = HomeAPIService(apiBaseURL: configuration.apiBaseURL,
                                     sampleData: nil)
        let dependencies = HomeSceneDIContainer.Dependencies(service: service)
        return HomeSceneDIContainer(dependencies: dependencies)
    }
    
    func makeSearchSceneDIContainer() -> SearchSceneDIContainer {
        let service = SearchAPIService(apiBaseURL: configuration.apiBaseURL,
                                       sampleData: makeAPISampleDataProviding { SearchSampleDataProviding() })
        let dependencies = SearchSceneDIContainer.Dependencies(service: service)
        return SearchSceneDIContainer(dependencies: dependencies)
    }
    
    func makeMoreSceneDIContainer() -> MoreSceneDIContainer {
        let service = MoreAPIService(apiBaseURL: configuration.apiBaseURL,
                                     sampleData: makeAPISampleDataProviding { MoreSampleDataProviding() })
        let dependencies = MoreSceneDIContainer.Dependencies(service: service)
        return MoreSceneDIContainer(dependencies: dependencies)
    }
    
    func makeSettingsSceneDIContainer() -> SettingsSceneDIContainer {
        let service = SettingsAPIService(apiBaseURL: configuration.apiBaseURL,
                                         sampleData: makeAPISampleDataProviding { SettingsSampleDataProviding() })
        let dependencies = SettingsSceneDIContainer.Dependencies(service: service)
        return SettingsSceneDIContainer(dependencies: dependencies)
    }
}

// MARK: - Helper
private extension SceneDIContainer {
    func makeAPISampleDataProviding(_ makeSampleData: () -> APISampleDataProviding) -> APISampleDataProviding? {
        switch self.configuration.mode {
        case .useSampleData:
            return makeSampleData()
        case .useRealData:
            return nil
        }
    }
}
