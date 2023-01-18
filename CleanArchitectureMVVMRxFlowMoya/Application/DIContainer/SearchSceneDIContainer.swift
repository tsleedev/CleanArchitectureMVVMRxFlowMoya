//
//  SearchSceneDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Domain
import Data
import UIKit

final class SearchSceneDIContainer {
    
    struct Dependencies {
        let repoNetworking: RepoNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    func makeSearchReposUseCase() -> SearchReposUseCaseProtocol {
        return SearchReposUseCase(reposRepository: makeReposRepository())
    }
    
    // MARK: - Repositories
    func makeReposRepository() -> ReposRepository {
        return ReposDAO(network: dependencies.repoNetworking)
    }
}
