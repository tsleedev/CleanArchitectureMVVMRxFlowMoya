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

// MARK: - SampleDataProviding
struct MoreSampleDataProviding: APISampleDataProviding {
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        guard let endpoint = endpoint as? MoreAPI else { return nil }
        switch endpoint {
        case .readItems:
            return APISampleData(statusCode: 200, delay: 1, jsonLoader: JSONFile.More.readItems200)
        }
    }
}
