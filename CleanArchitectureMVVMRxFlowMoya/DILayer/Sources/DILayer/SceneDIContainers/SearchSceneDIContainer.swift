//
//  SearchSceneDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import DomainLayer
import DataLayer
import UIKit

public final class SearchSceneDIContainer {
    struct Dependencies {
        let service: SearchAPIService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension SearchSceneDIContainer {
    func makeUseCase() -> SearchUseCaseProtocol {
        return SearchUseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension SearchSceneDIContainer {
    func makeRepository() -> SearchRepository {
        return SearchRepositoryImp(service: dependencies.service)
    }
}

// MARK: - SampleDataProviding
struct SearchSampleDataProviding: APISampleDataProviding {
    let mockData: [String: Data?]?
    
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        guard let endpoint = endpoint as? SearchAPI else { return nil }
        switch endpoint {
        case .readItems:
            let sampleData = mockData?[JSONFile.Search.readItems200.fileName] ?? JSONFile.Search.readItems200.sampleData
            return APISampleData(statusCode: 200, delay: 1, sampleData: sampleData)
        }
    }
}
