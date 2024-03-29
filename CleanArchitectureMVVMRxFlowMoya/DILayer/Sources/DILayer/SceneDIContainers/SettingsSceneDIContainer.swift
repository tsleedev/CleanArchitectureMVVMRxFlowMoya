//  
//  SettingsSceneDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import DomainLayer
import DataLayer
import UIKit

public final class SettingsSceneDIContainer {
    struct Dependencies {
        let service: SettingsAPIService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension SettingsSceneDIContainer {
    func makeUseCase() -> SettingsUseCaseProtocol {
        return SettingsUseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension SettingsSceneDIContainer {
    func makeRepository() -> SettingsRepository {
        return SettingsRepositoryImp(service: dependencies.service)
    }
}

// MARK: - SampleDataProviding
struct SettingsSampleDataProviding: APISampleDataProviding {
    let mockData: [String: Data?]?
    
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        guard let endpoint = endpoint as? SettingsAPI else { return nil }
        switch endpoint {
        case .readItems:
            let sampleData = mockData?[JSONFile.Settings.readItems200.fileName] ?? JSONFile.Settings.readItems200.sampleData
            return APISampleData(statusCode: 200, delay: 1, sampleData: sampleData)
        }
    }
}
