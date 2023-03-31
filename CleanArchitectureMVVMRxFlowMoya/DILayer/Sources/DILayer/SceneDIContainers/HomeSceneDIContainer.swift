//  
//  HomeSceneDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/13.
//

import DomainLayer
import DataLayer
import UIKit

public final class HomeSceneDIContainer {
    
    struct Dependencies {
        let networking: HomeNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    public func makeUseCase() -> HomeUseCaseProtocol {
        return HomeUseCase(repository: makeRepository())
    }
    
    // MARK: - Repositories
    private func makeRepository() -> HomeRepository {
        return HomeRepositoryImp(network: dependencies.networking)
    }
}
