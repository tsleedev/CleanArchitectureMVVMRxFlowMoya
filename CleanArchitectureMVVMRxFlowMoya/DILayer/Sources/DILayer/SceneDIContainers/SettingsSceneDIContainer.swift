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
