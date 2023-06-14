//  
//  HomeSceneDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/03/13.
//

import DomainLayer
import DataLayer
import UIKit

public final class HomeSceneDIContainer {
    struct Dependencies {
        let service: HomeAPIService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension HomeSceneDIContainer {
    func makeUseCase() -> HomeUseCaseProtocol {
        return HomeUseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension HomeSceneDIContainer {
    func makeRepository() -> HomeRepository {
        return HomeRepositoryImp(service: dependencies.service)
    }
}

// MARK: - SampleDataProviding
struct HomeSampleDataProviding: APISampleDataProviding {
    let mockData: [String: Data?]?
    
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        return nil
//        guard let endpoint = endpoint as? HomeAPI else { return nil }
//        switch endpoint {
//        case .readItems:
//            return APISampleData(statusCode: 200, delay: 1, sampleData: JSONFile.Home.readItems200.sampleData)
//        }
    }
}
