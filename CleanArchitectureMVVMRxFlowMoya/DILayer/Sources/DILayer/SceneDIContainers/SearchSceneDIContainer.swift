//
//  SearchSceneDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import DomainLayer
import DataLayer
import UIKit

public final class SearchSceneDIContainer {
    
    struct Dependencies {
        let networking: SearchNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    public func makeUseCase() -> SearchUseCaseProtocol {
        return SearchUseCase(repository: makeRepository())
    }
    
    // MARK: - Repositories
    private func makeRepository() -> SearchRepository {
        return SearchRepositoryImp(network: dependencies.networking)
    }
}
