//
//  MoreSceneDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/02/06.
//

import DomainLayer
import DataLayer
import UIKit

public final class MoreSceneDIContainer {
    struct Dependencies {
        let service: MoreAPIService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension MoreSceneDIContainer {
    func makeUseCase() -> MoreUseCaseProtocol {
        return MoreUseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension MoreSceneDIContainer {
    func makeRepository() -> MoreRepository {
        return MoreRepositoryImp(service: dependencies.service)
    }
}
